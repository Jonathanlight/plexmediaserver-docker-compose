FROM ubuntu:16.04

ARG S6_OVERLAY_VERSION=v1.22.1.0
ARG S6_OVERLAY_ARCH=amd64
ARG PLEX_BUILD=linux-x86_64
ARG PLEX_DISTRO=debian
ARG DEBIAN_FRONTEND="noninteractive"
ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"

ENTRYPOINT ["/init"]

RUN \
# Update and get dependencies
    apt-get update && \
    apt-get install -y \
      tzdata \
      curl \
      xmlstarlet \
      uuid-runtime \
      unrar \
    && \

# Fetch and extract S6 overlay
    curl -J -L -o /tmp/s6-overlay-${S6_OVERLAY_ARCH}.tar.gz https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-${S6_OVERLAY_ARCH}.tar.gz && \
    tar xzf /tmp/s6-overlay-${S6_OVERLAY_ARCH}.tar.gz -C / && \

# Add user
    useradd -U -d /config -s /bin/false plex && \
    usermod -G users plex && \

# Cleanup
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

ARG TAG=beta
ARG URL=

COPY root/ /

RUN \
# Save version and install
    /installBinary.sh

HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD /healthcheck.sh || exit 1
