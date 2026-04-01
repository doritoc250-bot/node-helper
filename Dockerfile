FROM node:20-alpine
WORKDIR /app
RUN apk add --no-cache curl
COPY package.json ./
RUN npm install
RUN mkdir -p public/uv && \
    curl -L "https://cdn.jsdelivr.net/npm/@titaniumnetwork-dev/uv@3.2.10/dist/uv.bundle.js" -o public/uv/uv.bundle.js && \
    curl -L "https://cdn.jsdelivr.net/npm/@titaniumnetwork-dev/uv@3.2.10/dist/uv.config.js" -o public/uv/uv.config.js && \
    curl -L "https://cdn.jsdelivr.net/npm/@titaniumnetwork-dev/uv@3.2.10/dist/uv.sw.js" -o public/uv/uv.sw.js && \
    curl -L "https://cdn.jsdelivr.net/npm/@titaniumnetwork-dev/uv@3.2.10/dist/uv.handler.js" -o public/uv/uv.handler.js
COPY . .
EXPOSE 8080
CMD ["node", "index.js"]
