FROM alpine:latest

# Set environment variable to disable interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Define the DarkIce version as a build argument
ARG DARKICE_VERSION=1.4-r2

# Install necessary packages and DarkIce
RUN apk add --no-cache \
    alsa-lib \
    darkice=$DARKICE_VERSION \
    lame \
    libshout \
    sox

# Copy your configuration file
COPY darkice.cfg /etc/

# Set the entry point for the container
ENTRYPOINT [ "darkice" ]
