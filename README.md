# mc-modpack-server-container

A Docker container for hosting any Minecraft modpack server. Provide a direct URL to a server pack `.zip` file and the container will download, extract, and run it automatically — no manual setup required.

## Features

- Automatic modpack download and extraction on first start
- EULA acceptance via environment variable
- Configurable JVM memory allocation
- Persistent server data via Docker volume
- Runs as a non-root user (`minecraft:999`)
- RCON port exposed locally only (`127.0.0.1`)

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

1. **Clone the repository**

   ```bash
   git clone https://github.com/Zakonik/mc-modpack-server-container.git
   cd mc-modpack-server-container
   ```

2. **Create your `.env` file**

   ```bash
   cp .env.example .env
   ```

   Then edit `.env` with your values (see [Environment Variables](#environment-variables)).

3. **Build and start the container**

   ```bash
   docker compose build
   docker compose up -d
   ```

4. **Check logs**

   ```bash
   docker compose logs -f
   ```

On the first start, the container will download the modpack ZIP from `SERVER_PACK_URL`, extract it, and launch the server. On subsequent starts, the download is skipped automatically.

## Environment Variables

| Variable | Required | Default | Description |
|---|---|---|---|
| `SERVER_PACK_URL` | Yes (first start only) | *(empty)* | Direct URL to the server pack `.zip` file |
| `EULA` | Yes | *(empty)* | Must be set to `true` to accept the [Minecraft EULA](https://www.minecraft.net/en-us/eula) |
| `JVM_XMX` | No | `8G` | Maximum RAM allocated to the JVM |
| `JVM_XMS` | No | `4G` | Initial RAM allocated to the JVM |
| `START_SCRIPT` | No | `start.sh` | Name of the startup script inside the extracted server pack |
| `HOST_SERVER_PATH` | Yes | *(empty)* | Absolute path on the host machine where server files will be stored |

> **Note:** `SERVER_PACK_URL` is only required on the first container start. Once the server pack has been downloaded and extracted, it can be removed from `.env`.

## Server Configuration

> 🚧 **Coming Soon**
>
> Support for configuring `server.properties` via environment variables (e.g. `MC_MOTD`, `MC_MAX_PLAYERS`, `MC_DIFFICULTY`) is planned and currently in development. See [#28](https://github.com/Zakonik/mc-modpack-server-container/issues/28) for details.

## Java Version

The container is currently built on **Java 21** (`eclipse-temurin:21-jre-jammy`). This is suitable for Minecraft 1.20.5+.

If your modpack requires a different Java version, you can override the base image at build time:

```bash
docker compose build --build-arg BASE_IMAGE=eclipse-temurin:17-jre-jammy
```

Common base images:
- Java 8: `eclipse-temurin:8-jre-jammy` — for Minecraft 1.12.2 and older
- Java 17: `eclipse-temurin:17-jre-jammy` — for Minecraft 1.18 – 1.20.4
- Java 21: `eclipse-temurin:21-jre-jammy` — for Minecraft 1.20.5+

## Known Limitations

- **Single Java version per image:** The container image is built with a fixed Java version. Support for pre-built multi-tag images (e.g. `java8`, `java17`, `java21`) is planned. See [#20](https://github.com/Zakonik/mc-modpack-server-container/issues/20).
- **Direct ZIP links only:** `SERVER_PACK_URL` must point to a direct `.zip` download. CurseForge, Modrinth, and other platform-specific URLs are not supported.
- **No automatic mod updates:** The container does not update mods after the initial installation.

## Project Structure

```
.
├── Dockerfile                  # Container image definition
├── compose.yaml                # Docker Compose configuration
├── .env.example                # Template for environment variables
└── Scripts/
    ├── ContainerStart.sh       # Container entrypoint — orchestrates startup
    ├── CheckEula.sh            # Validates EULA acceptance
    └── ChangeVariables.sh      # Patches variables in the extracted server pack
```

## License

This project is licensed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for details.
