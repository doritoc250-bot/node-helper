FROM node:20-alpine
WORKDIR /app
RUN apk add --no-cache curl
COPY package.json ./
RUN npm install
RUN mkdir -p public/uv && \
    curl -L "https://github.com/titaniumnetwork-dev/Ultraviolet/releases/download/v3.2.10/bundle.js" -o public/uv/uv.bundle.js && \
    curl -L "https://github.com/titaniumnetwork-dev/Ultraviolet/releases/download/v3.2.10/config.js" -o public/uv/uv.config.js && \
    curl -L "https://github.com/titaniumnetwork-dev/Ultraviolet/releases/download/v3.2.10/sw.js" -o public/uv/uv.sw.js && \
    curl -L "https://github.com/titaniumnetwork-dev/Ultraviolet/releases/download/v3.2.10/handler.js" -o public/uv/uv.handler.js
COPY . .
EXPOSE 8080
CMD ["node", "index.js"]
