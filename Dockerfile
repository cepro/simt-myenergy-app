FROM nginx:alpine

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy Flutter web build output to nginx html directory
COPY build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# nginx will run automatically as the base image's CMD
