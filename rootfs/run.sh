#!/usr/bin/env bash
# shellcheck shell=bash

set -e

DB_PATH="${DB_FILE:-/homeassistant/home-assistant_v2.db}"
PORT="${DATASETTE_PORT:-8001}"

echo "[INFO] Home-Assistant Datasette add-on"
echo "[INFO] Expecting database at: ${DB_PATH}"

# Wait until the Home-Assistant database file is present
while [[ ! -f "${DB_PATH}" ]]; do
  echo "[INFO] Database not found yet, waiting..."
  sleep 5
done

echo "[INFO] Starting Datasette on 0.0.0.0:${PORT}"
exec datasette \
  "${DB_PATH}" \
  --host 0.0.0.0 \
  --port "${PORT}" \
  --insecure \
  --setting sql_time_limit_ms 15000