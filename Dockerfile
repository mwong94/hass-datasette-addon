# Home Assistant Datasette add‑on
ARG BUILD_FROM=ghcr.io/hassio-addons/base-python:16.1.4
FROM ${BUILD_FROM}

# Copy runtime files
ENV PYTHONUNBUFFERED=1 LANG=C.UTF-8
COPY rootfs/ /
ENTRYPOINT ["/init"]
