# --- Stage 1: Build the application using Node.js (Pulled from AWS ECR Public) ---
FROM public.ecr.aws/docker/library/node:18-alpine AS builder
WORKDIR /app

# Copy dependency files and install them
COPY package*.json ./
# UPDATE THIS LINE 👇
RUN npm install --legacy-peer-deps

# Copy the rest of your application code and build it
COPY . .
RUN npm run build

# --- Stage 2: Serve the compiled static files using Nginx ---
FROM public.ecr.aws/nginx/nginx:alpine

# Clean out any default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy the compiled production-ready HTML/CSS/JS from the build stage
COPY --from=builder /app/out /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
