# Step 1: Use an official Node.js image to build the app
FROM node:16 AS build-stage

# Set working directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the angular app
RUN npm run build --prod

# Step 2: Use NGINX to serve the built angular app
FROM nginx:alpine AS production-stage

# Copy the built angular app from the built-stage
COPY --from=build-stage /app/dist/ang-test-app /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX to serve the app
CMD ["nginx", "-g", "daemon off;"]