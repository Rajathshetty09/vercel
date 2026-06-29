# Use the official AWS ECR Public Node image
FROM public.ecr.aws/docker/library/node:20-alpine
WORKDIR /app

# Copy package configuration files and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy all the application source code
COPY . .

# Build the production Next.js application
RUN npm run build

# Next.js production runs on port 3000 by default
EXPOSE 3000

# Start the native web server
CMD ["npm", "run", "start"]
