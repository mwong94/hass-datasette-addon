# Home Assistant Datasette add‑on
ARG BUILD_FROM=ghcr.io/hassio-addons/base-python:10.2.6
FROM ${BUILD_FROM}

# Copy runtime files
COPY rootfs/ /

