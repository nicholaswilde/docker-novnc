FROM alpine:3.13.0 as base
ARG VERSION=1.2.0
ARG WEBSOCKIFY_VERSION=0.9.0
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    git=2.30.2-r0 \
    curl=7.76.1-r0 && \
  echo "**** cleanup ****" && \
  rm -rf /tmp/* && \
  echo "**** download novnc ****" && \
  git clone https://github.com/novnc/noVNC.git -b v${VERSION} --depth=1 && \
  git clone https://github.com/novnc/websockify.git -b v${WEBSOCKIFY_VERSION} --depth=1 /noVNC/utils/websockify && \
  curl --remote-name --time-cond cacert.pem https://curl.se/ca/cacert.pem && \
  mv cacert.pem /noVNC/self.pem

FROM ghcr.io/linuxserver/baseimage-alpine:3.13
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
ENV REMOTE_HOST=localhost
ENV REMOTE_PORT=5900
WORKDIR /app
COPY --from=base /noVNC .
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN \
  echo "**** add repository ****" && \
  echo "@community https://dl-cdn.alpinelinux.org/alpine/v3.9/community/" | tee -a /etc/apk/repositories && \
  apk update && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ca-certificates=20191127-r5 \
    python3=3.8.10-r0 \
    python2=2.7.18-r1 \
    py2-numpy@community=1.15.4-r0 && \
  chown -R abc:abc /app && \
  echo "**** cleanup ****" && \
  rm -rf /tmp/*
VOLUME /app
EXPOSE 6080
CMD ["sh", "-c", "./utils/launch.sh --vnc ${REMOTE_HOST}:${REMOTE_PORT}"]
