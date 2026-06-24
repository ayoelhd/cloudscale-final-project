FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json .
RUN npm install --omit=dev

# Copy application source
COPY app.js .

# Expose port
EXPOSE 3000

# Health check built into the image
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', r => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))"

# Start the app
CMD ["node", "app.js"]
