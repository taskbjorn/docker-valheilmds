FROM debian:buster-slim

ENV SERVER_NAME Valheilm
ENV SERVER_PORT 2456
ENV WORLD_NAME Valhalla

ENV DEBIAN_FRONTEND noninteractive

# Install SteamCMD, Python and command line tools
RUN sed -i "s#deb http://deb.debian.org/debian buster main#deb http://deb.debian.org/debian buster main contrib non-free#g" /etc/apt/sources.list && \
    sed -i "s#deb http://security.debian.org/debian-security buster/updates main#deb http://security.debian.org/debian-security buster/updates main contrib non-free#g" /etc/apt/sources.list && \
    echo steamcmd steam/question select "I AGREE" | debconf-set-selections && \
    echo steamcmd steam/license note '' | debconf-set-selections && \
    dpkg --add-architecture i386 && \
    apt-get update -qq 2> /dev/null && \
    apt-get install -o=Dpkg::Use-Pty=0 -yqq \
        ca-certificates \
        curl \
        lib32stdc++6 \
        lib32gcc1 \
        libcurl4 \
        libsdl2-2.0-0:i386 \
        locales \
        steamcmd 2> /dev/null && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    ln -s /usr/games/steamcmd /usr/bin/steamcmd

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create and switch to a non-privileged user, copy entrypoint script
COPY valheilm-entrypoint.sh /

RUN groupadd --gid 1000 valheilm && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home valheilm && \
    mkdir -p /home/valheilm/.valheilm/helpers/ /home/valheilm/.valheilm/server/ && \
    mv -t /home/valheilm/.valheilm/helpers/ /valheilm-entrypoint.sh && \
    chown -R 1000:1000 /home/valheilm/.valheilm/helpers/ /home/valheilm/.valheilm/server/ && \
    chmod +x /home/valheilm/.valheilm/helpers/valheilm-entrypoint.sh

USER valheilm

# Download the latest server binary and create missing cache directory, launch server to generate configuration files, enable WebAdmin, enable MultiWebAdmin, disable takeover, enable workshop redirect
RUN steamcmd +@ShutdownOnFailedCommand +login anonymous +force_install_dir /home/valheilm/.valheilm/server +app_update 896660 validate +quit

# Run entrypoint script
WORKDIR /home/valheilm/.valheilm/server
EXPOSE 2456 2457
ENTRYPOINT /home/valheilm/.valheilm/helpers/valheilm-entrypoint.sh

