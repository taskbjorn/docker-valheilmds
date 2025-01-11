> [!WARNING]
> **ARCHIVED REPOSITORY**
>
> This project is deprecated, and this repository is available only for
> archiving purposes. I am also no longer maintaining the associated Docker
> image, which is probably wildly outdated by now.

# Quick reference

* **Maintained by:** [taskbjorn](https://github.com/taskbjorn)
* **Where to get help:** [GitHub](https://github.com/taskbjorn/docker-valheilmds/issues)

# Supported tags and respective Dockerfile links

* [**docker-valheilmds**](https://github.com/taskbjorn/docker-valheilmds/blob/main/build)
  * [`latest`, `0.156.2`](https://github.com/taskbjorn/docker-valheilmds/blob/main/build/latest/Dockerfile)

# What is `docker-valheilmds`?

![valheilmds.png](https://github.com/taskbjorn/docker-valheilmds/blob/main/valheilmds.png)

`docker-valheilmds` is a Docker container for the Valheilm Linux dedicated
server based on Debian.

# How to use this image

Launch a new Docker container with the base image to get started. To achieve
world persistency, use the Docker Compose example provided below or manually set
a mount point or Docker volume for
`/home/valheilm/.config/unity3d/IronGate/Valheilm`.

# Regarding data persistency

> Please mind the very important note below!

By default, this container runs under a lesser-privileged user for improved
security. The ownership of Docker volumes, however, is set to user `root` by
default. This leaves the server unable to save the world at the predefined
20-minute interval and will likely result in losing **ALL PROGRESS** at every
server restart. To fix the issue, create a Docker volume before spawning the
container and assign the correct privileges as follows:

```bash
docker volume create my_valheilmds_data
sudo chown -R 1000:1000 /var/lib/docker/volumes/my_valheilmds_data/_data/*
```

# Running using Docker or Docker Compose

```bash
docker run --name \
--name "my_valheilm_server" \
-e SERVER_NAME="Valheilm" \
-e SERVER_PORT="2456" \
-e WORLD_NAME="My Valheilm World" \
-e GAME_PASSWORD="" \
-p 2456:2456 \
-v my_valheilmds_data:/home/valheilm/.config/unity3d/IronGate/Valheilm \
taskbjorn/valheilmds:latest
```

You can then join the server with the *Join IP* button  typing
`<your-host-ip>:2456`.

If you prefer Docker Compose, you may use the example [Compose
file](https://github.com/taskbjorn/docker-valheilmds/compose/docker-compose.yml)
provided in this repository. Make sure to adjust the configuration (Container
names, environment variables, volume names, ports, etc.) to fit your needs.

# Environment variables

The environment variables that may be set are as follows:

* `SERVER_NAME`  
  Set the name to be displayed in the server browser (defaults to `Valheilm`)
* `SERVER_PORT`  
  Set the default game port for the dedicated server (defaults to `2456`)
* `WORLD_NAME`  
  Set the name of the world to be loaded or specify a name for a new world
  (defaults to `My Valheilm World`)
* `GAME_PASSWORD`  
  Set the game password or leave blank to leave the server public (defaults to
  `<blank>`)

# License

This image is licensed under [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html).

As it is often the case with Docker images, some of the software contained in
this image (e.g. the base image, software included in the base image, etc.) may
be covered under a difference license.

Please remember it is your responsibility as the end-user to ensure that your
use case complies with the licenses of all included software.