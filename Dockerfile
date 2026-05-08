FROM node:18

# Install Lua 5.3
RUN apt-get update && apt-get install -y lua5.3 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy application files
COPY . .

# Create temp directory
RUN mkdir -p /tmp/lua-dumper && chmod 777 /tmp/lua-dumper

# Expose port
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
