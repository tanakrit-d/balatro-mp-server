ARG NODE_VERSION=24

# ------------------------------------------------------------
# Build
# ------------------------------------------------------------
FROM node:${NODE_VERSION}-bookworm AS builder

ARG SERVER_REPO=https://github.com/Balatro-Multiplayer/BalatroMultiplayerAPI-Server.git
ARG SERVER_REF=main

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        python3 \
        make \
        g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN git init \
    && git remote add origin "${SERVER_REPO}" \
    && git fetch --depth 1 origin "${SERVER_REF}" \
    && git checkout --detach FETCH_HEAD

RUN npm ci

RUN npm run build

RUN npm prune --omit=dev


# ------------------------------------------------------------
# Runtime
# ------------------------------------------------------------
FROM node:${NODE_VERSION}-bookworm-slim AS runtime

ENV NODE_ENV=production

WORKDIR /app

COPY --from=builder /src/package.json ./
COPY --from=builder /src/package-lock.json ./
COPY --from=builder /src/node_modules ./node_modules
COPY --from=builder /src/dist ./dist

RUN mkdir -p /app/data

EXPOSE 8788/tcp

CMD ["node", "dist/main.js"]