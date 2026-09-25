# Balatro Multiplayer Server

Docker image for the Balatro Multiplayer private server.

The image is built from the official Linux server binary published by the Balatro Multiplayer project.

## Image

```text
ghcr.io/tanakrit-d/balatro-multiplayer-server:latest
```

Versioned tags are also published, for example:

```text
ghcr.io/tanakrit-d/balatro-multiplayer-server:v0.5.5
```

## Docker Compose

```yaml
services:
  balatro-multiplayer:
    image: ghcr.io/tanakrit-d/balatro-multiplayer-server:latest
    container_name: balatro-multiplayer
    restart: unless-stopped

    ports:
      - "8788:8788/tcp"
```

Start the server with:

```bash
docker compose up -d
```

View logs with:

```bash
docker compose logs -f
```

## Client configuration

Configure Balatro Multiplayer to connect to the Docker host on port `8788`.

Example:

```lua
return {
    ["server_url"] = "192.168.1.10",
    ["server_port"] = 8788,
}
```

Use the Docker host's LAN IP, hostname, or Tailscale address as appropriate.

## Updates

GitHub Actions checks the upstream Balatro Multiplayer releases on a schedule.

When a new server release is published, the workflow builds and pushes:

```text
:<version>
:latest
```

Existing versions are not rebuilt unless the workflow is manually run with the force option enabled.

## Upstream

Balatro Multiplayer:

https://github.com/Balatro-Multiplayer/BalatroMultiplayer

Private server documentation:

https://balatromp.com/docs/advanced/private-server