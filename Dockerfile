FROM node:18-alpine

# Install Lua
RUN apk add --no-cache lua5.3 lua5.3-dev

WORKDIR /app

# Copy package files first
COPY package*.json ./

# Fix npm install issue
RUN npm install --production --legacy-peer-deps

# Copy application files
COPY . .

# Create temp directory with proper permissions
RUN mkdir -p /tmp/lua-dumper && chmod 777 /tmp/lua-dumper

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node -e "require('http').get('http://localhost:3000/api/health', (r) => r.statusCode === 200 ? process.exit(0) : process.exit(1))"

# Start the application
CMD ["node", "server.js"]
