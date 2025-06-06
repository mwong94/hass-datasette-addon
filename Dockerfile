# Home Assistant Datasette add-on
ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.1.4
FROM ${BUILD_FROM}

# ------------------------------------------------------------------------------
# Metadata (shown in Home-Assistant supervisor UI)
# ------------------------------------------------------------------------------
LABEL \
    io.hass.name="Datasette" \
    io.hass.description="Datasette UI for the Home-Assistant database" \
    io.hass.version="0.1.11" \
    io.hass.type="addon"

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------
ENV \
    PYTHONUNBUFFERED=1 \
    LANG=C.UTF-8 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# ------------------------------------------------------------------------------
# Install runtime dependencies
# ------------------------------------------------------------------------------
RUN apk add --no-cache \
    python3 \
    py3-pip \
    sqlite
RUN pip3 install --no-cache-dir --use-pep517 --only-binary=:all: datasette==0.61.1
RUN pip3 cache purge

# ------------------------------------------------------------------------------
# Copy runtime files
# ------------------------------------------------------------------------------
COPY rootfs/ /

# Make sure scripts are executable
RUN chmod a+x /run.sh /etc/services.d/datasette/run /etc/services.d/datasette/finish

# ------------------------------------------------------------------------------
# Install runtime dependencies
# ------------------------------------------------------------------------------
RUN apk add --no-cache \
        python3 \
        py3-pip \
        sqlite \
    && pip3 install --no-cache-dir datasette==0.61.1 \
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