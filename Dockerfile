# nginx 1.31.2-alpine3.23 (mainline), pinned by digest. Dependabot
# (docker ecosystem) refreshes the digest/version automatically.
FROM nginx:1.31.2-alpine3.23@sha256:54f2a904c251d5a34adf545a72d32515a15e08418dae0266e23be2e18c66fefa

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy Flutter web build output to nginx html directory
COPY build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# nginx will run automatically as the base image's CMD
