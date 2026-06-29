# --- Stage 1: Build the application using Node.js 20 ---
FROM public.ecr.aws/docker/library/node:20-alpine AS builder
WORKDIR /app

# Copy dependency files and install them
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy the rest of your application code
COPY . .

# Set environment variable to force static export output if supported, then build
ENV NEXT_OUTPUT=export
RUN npm run build || npx next build

# --- Stage 2: Serve the compiled static files using Nginx ---
FROM public.ecr.aws/nginx/nginx:alpine

# Clean out any default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy the compiled production-ready static files. 
# Next.js static export places files in 'out'. If it fell back to default, we check '.next'
COPY --from=builder /app/out/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
