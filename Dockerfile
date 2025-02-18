# Stage 1: Build the app
FROM node:14-alpine as build
WORKDIR /app
# Copy package files and install dependencies
COPY package*.json ./
RUN npm install
# Copy the rest of your source code
COPY . .
# Build the Vue.js app (this produces the 'dist' folder)
RUN npm run build

# Stage 2: Serve the app using Nginx
FROM nginx:alpine
# Copy the build output from the previous stage to Nginx's html directory
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
