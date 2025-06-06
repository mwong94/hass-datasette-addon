# /addons/datasette/Dockerfile
# This file defines how to build the Docker container for the addon.

# Use an official Home Assistant base image.
# The 'BUILD_FROM' argument is provided by the Home Assistant build system
# and ensures the correct base image is used for your architecture.
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell for subsequent commands
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install datasette using pip
RUN pip install --no-cache-dir datasette

# Copy the run script into the container
COPY run.sh /

# Make the run script executable
RUN chmod a+x /run.sh

# This command is executed when the container starts
CMD [ "/run.sh" ]
