#!/usr/bin/with-contenv bashio
set -e

# One-time venv creation (persists in /data)
if [ ! -d /data/venv ]; then
  python3 -m venv /data/venv
fi

# Make sure we have the latest Datasette (and pip) every start
/data/venv/bin/pip install --no-cache-dir --upgrade pip
/data/venv/bin/pip install --no-cache-dir --upgrade datasette

PORT="$(bashio::config 'port')"
DB_DIR="$(bashio::config 'db_dir')"

# Make sure Datasette is up‑to‑date (handles add‑on upgrades)
/data/venv/bin/pip install --no-cache-dir --upgrade datasette

exec /data/venv/bin/datasette serve "${DB_DIR:-/homeassistant/home-assistant_v2.db}" \
    --host 0.0.0.0 --port "${PORT:-8001}" --cors
