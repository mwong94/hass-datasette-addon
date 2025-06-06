#!/usr/bin/with-contenv bashio
# /addons/datasette/run.sh
# This script is the entry point for the addon. It starts the datasette server.

bashio::log.info "Starting Datasette server..."

bashio::log.info "Activating virtual environment..."
source /opt/venv/bin/activate

# Read the configured port from the addon options.
# The value is set on the "Configuration" tab of the addon page.
PORT=$(bashio::config 'port')

bashio::log.info "Datasette will be available at http://<your-home-assistant-ip>:${PORT}"

# The Home Assistant database file.
# We can access it because we mapped the /config directory in config.yaml
DB_FILE="/config/home-assistant_v2.db"

# Check if the database file exists
if [ ! -f "$DB_FILE" ]; then
    bashio::log.error "Database file not found at ${DB_FILE}"
    bashio::log.error "Please ensure Home Assistant is running and the path is correct."
    exit 1
fi

# Start datasette.
# --host 0.0.0.0 makes it accessible from outside the container.
# The port is now configurable via the addon options.
# The 'exec' command replaces the shell process with the datasette process.
exec datasette serve "${DB_FILE}" \
    --host "0.0.0.0" \
    --port "${PORT}"
