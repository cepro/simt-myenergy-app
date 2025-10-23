const CACHE_NAME = 'myenergy-v1';
const VERSION_CACHE = 'myenergy-version';

// Core app files to cache
const APP_SHELL = [
  '/',
  '/index.html',
  '/main.dart.js',
  '/flutter.js',
  '/flutter_bootstrap.js',
  '/manifest.json',
  '/favicon.png',
  '/icons/Icon-192.png',
  '/icons/Icon-512.png',
  '/canvaskit/canvaskit.js',
  '/canvaskit/canvaskit.wasm'
];

let currentVersion = null;

// Install event - cache app shell
self.addEventListener('install', (event) => {
  console.log('[SW] Install event');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('[SW] Caching app shell');
        return cache.addAll(APP_SHELL);
      })
      .then(() => {
        // Get initial version
        return fetch('/version.json')
          .then(response => response.json())
          .then(versionData => {
            currentVersion = `${versionData.version}+${versionData.build_number}`;
            console.log('[SW] Initial version:', currentVersion);
          });
      })
      .then(() => self.skipWaiting())
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  console.log('[SW] Activate event');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME && cacheName !== VERSION_CACHE) {
            console.log('[SW] Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => {
      return self.clients.claim();
    })
  );
});

// Fetch event - serve from cache, check for updates
self.addEventListener('fetch', (event) => {
  // Handle version.json specially for update checking
  if (event.request.url.endsWith('/version.json')) {
    event.respondWith(
      fetch(event.request)
        .then(response => {
          const responseClone = response.clone();
          responseClone.json().then(versionData => {
            const newVersion = `${versionData.version}+${versionData.build_number}`;
            if (currentVersion && currentVersion !== newVersion) {
              console.log('[SW] New version detected:', newVersion, 'Current:', currentVersion);
              // Notify all clients about the update
              self.clients.matchAll().then(clients => {
                clients.forEach(client => {
                  client.postMessage({
                    type: 'UPDATE_AVAILABLE',
                    currentVersion: currentVersion,
                    newVersion: newVersion
                  });
                });
              });
            }
            currentVersion = newVersion;
          });
          return response;
        })
        .catch(() => {
          // Fallback to cached version if network fails
          return caches.match('/version.json');
        })
    );
    return;
  }

  // For other requests, try cache first, then network
  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        // Return cached version if available
        if (response) {
          // For HTML requests, also fetch from network to check for updates
          if (event.request.destination === 'document' || 
              event.request.url.endsWith('.js') || 
              event.request.url.endsWith('.css')) {
            fetch(event.request).then(fetchResponse => {
              if (fetchResponse.status === 200) {
                const responseClone = fetchResponse.clone();
                caches.open(CACHE_NAME).then(cache => {
                  cache.put(event.request, responseClone);
                });
              }
            }).catch(() => {
              // Network error, stick with cache
            });
          }
          return response;
        }

        // Not in cache, fetch from network
        return fetch(event.request).then((fetchResponse) => {
          // Don't cache non-successful responses
          if (!fetchResponse || fetchResponse.status !== 200 || fetchResponse.type !== 'basic') {
            return fetchResponse;
          }

          // Cache successful responses
          const responseToCache = fetchResponse.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseToCache);
          });

          return fetchResponse;
        });
      })
  );
});

// Handle skip waiting message from client
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    console.log('[SW] Received skip waiting message');
    self.skipWaiting();
  }
});