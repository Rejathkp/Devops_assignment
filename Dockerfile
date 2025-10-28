# Use lightweight Node image
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package.json + package-lock.json if present
COPY package.json package-lock.json* ./

# Install production dependencies only (change for dev)
RUN npm ci --only=production || npm install

# Copy source
COPY . .

# Expose port (app listens on 3000)
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
