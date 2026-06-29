# --- Stage 1: Build the application using Node.js ---
FROM node:18-alpine AS builder
WORKDIR /app

# Copy dependency files and install them
COPY package*.json ./
RUN npm install

# Copy the rest of your application code and build it
COPY . .
RUN npm run build

# --- Stage 2: Serve the compiled static files using Nginx ---
FROM public.ecr.aws/nginx/nginx:alpine

# Clean out any default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy the compiled production-ready HTML/CSS/JS from the build stage
# Note: Next.js standard export outputs to '.next' or 'out' directory. 
# If your build script generates a 'build' folder instead, change 'out' to 'build' below.
COPY --from=builder /app/out /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
