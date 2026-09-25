FROM debian:bookworm-slim

ARG VERSION
ARG SERVER_URL

LABEL org.opencontainers.image.version="${VERSION}"

RUN test -n "$SERVER_URL" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
    && curl --fail --location \
        "$SERVER_URL" \
        --output /usr/local/bin/balatro-mp-server \
    && chmod +x /usr/local/bin/balatro-mp-server \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

EXPOSE 8788/tcp

ENTRYPOINT ["/usr/local/bin/balatro-mp-server"]