# Home Assistant Datasette add‑on
ARG BUILD_FROM=ghcr.io/hassio-addons/base-python:10.2.6
FROM ${BUILD_FROM}

# Copy runtime files
COPY rootfs/ /

# Build virtual environment in /data (persistent)
RUN python -m venv /data/venv \
    && /data/venv/bin/pip install --no-cache-dir --upgrade pip \
    && /data/venv/bin/pip install --no-cache-dir datasette
