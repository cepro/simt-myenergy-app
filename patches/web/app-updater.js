// MyEnergy App Update Manager
class AppUpdater {
  constructor() {
    this.currentVersion = null;
    this.serviceWorkerRegistration = null;
    this.updateCheckInterval = null;
    
    this.init();
  }

  async init() {
    // Get current version
    try {
      const versionResponse = await fetch('/version.json');
      const versionData = await versionResponse.json();
      this.currentVersion = `${versionData.version}+${versionData.build_number}`;
      console.log('[AppUpdater] Current version:', this.currentVersion);
    } catch (error) {
      console.error('[AppUpdater] Failed to get version:', error);
    }

    // Register service worker
    if ('serviceWorker' in navigator) {
      try {
        this.serviceWorkerRegistration = await navigator.serviceWorker.register('/sw.js');
        console.log('[AppUpdater] Service Worker registered');
        
        // Listen for updates from service worker
        navigator.serviceWorker.addEventListener('message', (event) => {
          this.handleServiceWorkerMessage(event);
        });

        // Check for updates when service worker updates
        this.serviceWorkerRegistration.addEventListener('updatefound', () => {
          console.log('[AppUpdater] Service worker update found');
          this.showUpdateNotification();
        });

      } catch (error) {
        console.error('[AppUpdater] Service Worker registration failed:', error);
      }
    }

    // Start periodic version checking (every 5 minutes)
    this.startPeriodicVersionCheck();
  }

  handleServiceWorkerMessage(event) {
    const { data } = event;
    
    if (data.type === 'UPDATE_AVAILABLE') {
      console.log('[AppUpdater] Update available:', data.newVersion);
      this.showUpdateNotification(data.newVersion, data.currentVersion);
    }
  }

  showUpdateNotification(newVersion = null) {
    // Remove existing notification if any
    this.removeUpdateNotification();

    // Create update notification
    const notification = document.createElement('div');
    notification.id = 'app-update-notification';
    notification.innerHTML = `
      <div style="
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 10000;
        background: #2196F3;
        color: white;
        padding: 16px 20px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        max-width: 400px;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        font-size: 14px;
        line-height: 1.4;
      ">
        <div style="display: flex; align-items: center; gap: 12px;">
          <div style="flex: 1;">
            <div style="font-weight: 600; margin-bottom: 4px;">
              ✨ Update Available
            </div>
            <div style="opacity: 0.9; font-size: 13px;">
              ${newVersion ? `New version ${newVersion} is ready` : 'A new version is available'}
            </div>
          </div>
          <button 
            onclick="appUpdater.applyUpdate()" 
            style="
              background: rgba(255,255,255,0.2);
              border: 1px solid rgba(255,255,255,0.3);
              color: white;
              padding: 8px 16px;
              border-radius: 6px;
              cursor: pointer;
              font-size: 13px;
              font-weight: 500;
              transition: background 0.2s;
            "
            onmouseover="this.style.background='rgba(255,255,255,0.3)'"
            onmouseout="this.style.background='rgba(255,255,255,0.2)'"
          >
            Refresh
          </button>
          <button 
            onclick="appUpdater.dismissUpdate()" 
            style="
              background: none;
              border: none;
              color: rgba(255,255,255,0.8);
              cursor: pointer;
              font-size: 16px;
              padding: 4px;
              line-height: 1;
            "
            title="Dismiss"
          >
            ×
          </button>
        </div>
      </div>
    `;

    document.body.appendChild(notification);

    // Auto-dismiss after 30 seconds if user doesn't interact
    setTimeout(() => {
      this.removeUpdateNotification();
    }, 30000);
  }

  removeUpdateNotification() {
    const existing = document.getElementById('app-update-notification');
    if (existing) {
      existing.remove();
    }
  }

  async applyUpdate() {
    console.log('[AppUpdater] Applying update');
    
    this.removeUpdateNotification();
    
    // Show loading indicator
    this.showLoadingIndicator();
    
    try {
      // Tell service worker to skip waiting and activate
      if (this.serviceWorkerRegistration && this.serviceWorkerRegistration.waiting) {
        this.serviceWorkerRegistration.waiting.postMessage({ type: 'SKIP_WAITING' });
      }
      
      // Clear caches
      if ('caches' in window) {
        const cacheNames = await caches.keys();
        await Promise.all(
          cacheNames.map(cacheName => caches.delete(cacheName))
        );
      }
      
      // Force reload
      window.location.reload(true);
      
    } catch (error) {
      console.error('[AppUpdater] Update failed:', error);
      this.removeLoadingIndicator();
      alert('Update failed. Please refresh the page manually.');
    }
  }

  dismissUpdate() {
    this.removeUpdateNotification();
  }

  showLoadingIndicator() {
    const loader = document.createElement('div');
    loader.id = 'app-update-loader';
    loader.innerHTML = `
      <div style="
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(255,255,255,0.9);
        z-index: 20000;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      ">
        <div style="text-align: center;">
          <div style="
            width: 40px;
            height: 40px;
            border: 3px solid #f0f0f0;
            border-top: 3px solid #2196F3;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 16px auto;
          "></div>
          <div style="color: #666; font-size: 16px;">Updating app...</div>
        </div>
      </div>
      <style>
        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }
      </style>
    `;
    
    document.body.appendChild(loader);
  }

  removeLoadingIndicator() {
    const loader = document.getElementById('app-update-loader');
    if (loader) {
      loader.remove();
    }
  }

  startPeriodicVersionCheck() {
    // Check for updates every 5 minutes
    this.updateCheckInterval = setInterval(() => {
      this.checkForUpdates();
    }, 5 * 60 * 1000);
    
    // Also check 30 seconds after page load (in case user left tab open)
    setTimeout(() => {
      this.checkForUpdates();
    }, 30000);
  }

  async checkForUpdates() {
    try {
      const versionResponse = await fetch('/version.json?t=' + Date.now());
      const versionData = await versionResponse.json();
      const latestVersion = `${versionData.version}+${versionData.build_number}`;
      
      if (this.currentVersion && this.currentVersion !== latestVersion) {
        console.log('[AppUpdater] Manual check: Update available', latestVersion);
        this.showUpdateNotification(latestVersion, this.currentVersion);
        this.currentVersion = latestVersion;
      }
    } catch (error) {
      console.error('[AppUpdater] Version check failed:', error);
    }
  }

  destroy() {
    if (this.updateCheckInterval) {
      clearInterval(this.updateCheckInterval);
    }
    this.removeUpdateNotification();
    this.removeLoadingIndicator();
  }
}

// Initialize app updater when DOM is ready
let appUpdater;
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    appUpdater = new AppUpdater();
  });
} else {
  appUpdater = new AppUpdater();
}