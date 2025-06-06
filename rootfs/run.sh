#!/usr/bin/with-contenv bashio

set -e

# Get configuration values
DB_PATH="$(bashio::config 'db_file')"
PORT="$(bashio::config 'port')"

echo "[INFO] Home-Assistant Datasette add-on"
echo "[INFO] Expecting database at: ${DB_PATH}"

# Wait until the Home-Assistant database file is present
while [[ ! -f "${DB_PATH}" ]]; do
  echo "[INFO] Database not found yet, waiting..."
  sleep 5
done

echo "[INFO] Starting Datasette on 0.0.0.0:${PORT}"
exec venv/bin/datasette \
  "${DB_PATH}" \
  --host 0.0.0.0 \
  --port "${PORT}" \
  --insecure \
  --setting sql_time_limit_ms 15000