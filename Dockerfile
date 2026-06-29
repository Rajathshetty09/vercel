# Use the official AWS ECR Public Node image
FROM public.ecr.aws/docker/library/node:20-alpine
WORKDIR /app

# Copy dependency structures and install them cleanly
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy your source code
COPY . .

# Build the Next.js production server files
RUN npm run build

# Expose Next.js's standard application port
EXPOSE 3000

# Run the live Next.js production server
CMD ["npm", "run", "start"]
