#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# VARs
PUID="${PUID:-100}"
PGID="${PGID:-101}"
PIDFILE="/minidlna/minidlna.pid"

# Remove old pid if it exists
[ -f $PIDFILE ] && rm -f $PIDFILE

# Change user and group identifier
groupmod --non-unique --gid "$PGID" minidlna
usermod --non-unique --uid "$PUID" minidlna

# Change configuration
: > /etc/minidlna.conf
for VAR in $(env); do
  if [[ "$VAR" =~ ^MINIDLNA_ ]]; then
    if [[ "$VAR" =~ ^MINIDLNA_MEDIA_DIR ]]; then
      minidlna_name='media_dir'
    else
      minidlna_name=$(echo "$VAR" | sed -r "s/MINIDLNA_(.*)=.*/\\1/g" | tr '[:upper:]' '[:lower:]')
    fi
    minidlna_value=$(echo "$VAR" | sed -r "s/.*=(.*)/\\1/g")
    echo "${minidlna_name}=${minidlna_value}" >> /etc/minidlna.conf
  fi
done
echo "root_container=V" >> /etc/minidlna.conf
echo "db_dir=/minidlna/cache" >> /etc/minidlna.conf
echo "log_dir=/minidlna/" >>/etc/minidlna.conf

# Set permissions
mkdir -p /minidlna/cache
chown -R "${PUID}:${PGID}" /minidlna


echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen --purge fr_FR.UTF-8
dpkg-reconfigure --frontend=noninteractive locales
export LANGUAGE=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8

# Start daemon
#exec su-exec minidlna /usr/sbin/minidlnad -P "$PIDFILE" -S "$@"
#exec minidlna /usr/sbin/minidlnad -P "$PIDFILE" -S "$@"
./etc/init.d/minidlna start
tail -f /dev/null
