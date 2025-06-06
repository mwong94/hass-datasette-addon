# Home Assistant Datasette add-on
ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.1.4
FROM ${BUILD_FROM}

# ------------------------------------------------------------------------------
# Metadata (shown in Home-Assistant supervisor UI)
# ------------------------------------------------------------------------------
LABEL \
    io.hass.name="Datasette" \
    io.hass.description="Datasette UI for the Home-Assistant database" \
    io.hass.version="0.1.7" \
    io.hass.type="addon"

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------
ENV \
    PYTHONUNBUFFERED=1 \
    LANG=C.UTF-8 \
    DATA_DIR=/data \
    DB_FILE=/config/home-assistant_v2.db \
    DATASETTE_PORT=8001

# ------------------------------------------------------------------------------
# Install runtime + build dependencies, build Datasette, strip build deps
# ------------------------------------------------------------------------------
RUN apk add --no-cache \
        python3 \
        py3-pip \
        sqlite \
    # ---- build deps (will be removed afterwards) ----
    && apk add --no-cache --virtual .build-deps \
        build-base \
        gcc \
        musl-dev \
        libffi-dev \
        openssl-dev \
        rust \
        cargo \
        sqlite-dev \
        pkgconf \
    # ---- Python packages ----
    && pip3 install --no-cache-dir datasette==0.65.1 \
    # ---- clean-up ----
    && apk del .build-deps \
    && pip3 cache purge

# ------------------------------------------------------------------------------
# Copy runtime files
# ------------------------------------------------------------------------------
COPY rootfs/ /

# Make sure the entry-point script is executable
RUN chmod a+x /run.sh

# ------------------------------------------------------------------------------
# Expose port & define default command
# ------------------------------------------------------------------------------
EXPOSE ${DATASETTE_PORT}
CMD ["/run.sh"]