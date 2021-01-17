FROM debian:buster
#FROM raspbian/stretch
LABEL maintainer "Guillaume HUE"

# Install
RUN apt-get update
RUN apt-get -y install bash curl minidlna tzdata
RUN apt-get -y install locales

COPY entrypoint.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]
ENTRYPOINT /usr/local/bin/entrypoint.sh

# Health check
#HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
#  curl --silent --fail localhost:8200 || exit 1

# Metadata params
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.opencontainers.image.title="MiniDLNA" \
      org.opencontainers.image.url="$VCS_URL" \
      org.opencontainers.image.authors="Guillaume HUE" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.source="$VCS_URL" \
      org.opencontainers.image.revision="$VCS_REF" \
      org.opencontainers.image.created="$BUILD_DATE"
