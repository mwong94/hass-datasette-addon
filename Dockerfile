# Home Assistant Datasette add-on
ARG BUILD_FROM=ghcr.io/hassio-addons/base-python:16.1.4
FROM ${BUILD_FROM}

# ------------------------------------------------------------------------------
# Metadata (shown in Home-Assistant supervisor UI)
# ------------------------------------------------------------------------------
LABEL \
    io.hass.name="Datasette" \
    io.hass.description="Datasette UI for the Home-Assistant database" \
    io.hass.version="0.1.16" \
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
# RUN python3 -m pip cache purge
RUN python3 -m pip install --no-cache-dir datasette==0.61.1

# ------------------------------------------------------------------------------
# Copy runtime files
# ------------------------------------------------------------------------------
COPY rootfs/ /

# Make sure scripts are executable
RUN chmod a+x /run.sh /etc/services.d/datasette/run /etc/services.d/datasette/finish

# ------------------------------------------------------------------------------
# Expose port & define default command
# ------------------------------------------------------------------------------
EXPOSE ${DATASETTE_PORT}
CMD ["/run.sh"]