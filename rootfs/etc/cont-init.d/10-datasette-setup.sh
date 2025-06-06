#!/usr/bin/with-contenv bashio
set -e

# Create venv once, upgrade Datasette on every boot / add-on update
if [ ! -d /data/venv ]; then
  bashio::log.info "Creating Python virtual-environment in /data/venv"
  python3 -m venv /data/venv
fi

bashio::log.info "Updating Datasette…"
/data/venv/bin/pip install --no-cache-dir --upgrade pip
/data/venv/bin/pip install --no-cache-dir --upgrade datasette
