# Use the official Nginx image from the Docker Hub
FROM nginx:latest

# Copy static website files to Nginx's default static content directory
COPY . /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx and keep it running
CMD ["nginx", "-g", "daemon off;"]
