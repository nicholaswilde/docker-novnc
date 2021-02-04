# Docker noVNC
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/novnc)](https://hub.docker.com/r/nicholaswilde/novnc)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/novnc)](https://hub.docker.com/r/nicholaswilde/novnc)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-novnc)](./LICENSE)
[![ci](https://github.com/nicholaswilde/docker-novnc/workflows/ci/badge.svg)](https://github.com/nicholaswilde/docker-novnc/actions?query=workflow%3Aci)
[![lint](https://github.com/nicholaswilde/docker-novnc/workflows/lint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-novnc/actions?query=workflow%3Alint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A multi-architecture Docker image for [noVNC](https://novnc.com/).

## Requirements
- [buildx](https://docs.docker.com/engine/reference/commandline/buildx/)

## Usage
### docker-compose
```
---
version: "2.1"
services:
  novnc:
    image: nicholaswilde/novnc
    container_name: novnc
    environment:
      - TZ=America/Los_Angeles #optional
      - PUID=1000   #optional
      - PGID=1000   #optional
      - REMOTE_HOST=localhost #optional
      - REMOTE_PORT=5900 #optional
    ports:
      - 6080:6080
    restart: unless-stopped
    volumes:
      - app:/app
volumes:
  app:
```
### docker cli
```bash
$ docker run -d \
  --name=novnc \
  -e TZ=America/Los_Angeles `# optional` \
  -e PUID=1000  `# optional` \
  -e PGID=1000   `# optional` \
  -e REMOTE_HOST=localhost `# optional` \
  -e REMOTE_PORT=5900 `# optional` \
  -p 6080:6080 \
  --restart unless-stopped \
  nicholaswilde/novnc
```

## Build

Check that you can build the following:
```bash
$ docker buildx ls
NAME/NODE    DRIVER/ENDPOINT             STATUS  PLATFORMS
mybuilder *  docker-container
  mybuilder0 unix:///var/run/docker.sock running linux/amd64, linux/arm64, linux/arm/v7
```

If you are having trouble building arm images on a x86 machine, see [this blog post](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/).

```
$ make build
```

## Pre-commit hook

If you want to automatically generate `README.md` files with a pre-commit hook, make sure you
[install the pre-commit binary](https://pre-commit.com/#install), and add a [.pre-commit-config.yaml file](./.pre-commit-config.yaml)
to your project. Then run:

```bash
pre-commit install
pre-commit install-hooks
```
Currently, this only works on `amd64` systems.

## License

[Apache 2.0 License](./LICENSE)

## Author
This project was started in 2020 by [Nicholas Wilde](https://github.com/nicholaswilde/).
