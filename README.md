# Balatro Multiplayer Server

Docker image for the Balatro Multiplayer private server.

The server is built from the [BalatroMultiplayerAPI-Server](https://github.com/Balatro-Multiplayer/BalatroMultiplayerAPI-Server) source rather than the prebuilt standalone server binary.

## Docker Compose

```yaml
services:
  balatro-multiplayer:
    image: ghcr.io/tanakrit-d/balatro-multiplayer-server:latest
    container_name: balatro-multiplayer
    restart: unless-stopped

    ports:
      - "8788:8788/tcp"

    volumes:
      - ./data:/app/data
```

Start the server:

```bash
docker compose up -d
```

View logs:

```bash
docker compose logs -f
```

## Client

Configure Balatro Multiplayer to connect to the Docker host on TCP port `8788`.

Use the host's LAN IP, hostname, or Tailscale address.

## Updates

GitHub Actions checks the upstream server repository daily.

When the upstream commit changes, a new image is built and published as:

```text
ghcr.io/tanakrit-d/balatro-multiplayer-server:latest
ghcr.io/tanakrit-d/balatro-multiplayer-server:sha-<commit>
```

Changes to the local Dockerfile or build workflow also trigger a rebuild.

## Data

Persistent server data is stored under:

```text
/app/data
```

Mount this directory to persistent storage to retain the server database between container recreations.

## Ports

| Port | Protocol | Purpose |
| --- | --- | --- |
| 8788 | TCP | Multiplayer server |

The server also starts an internal administration service on `127.0.0.1:8789`. It is not exposed by this image.
