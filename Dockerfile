FROM balenalib/raspberrypi0-2w-64-debian:bookworm

# Set the snapcast version
ARG SNAPCAST_VERSION=0.34.0

# Install dependencies for downloading and runtime
RUN install_packages \
    wget \
    ca-certificates \
    alsa-utils \
    avahi-daemon

# Download and install the appropriate snapclient package
# Automatically detects architecture (arm64 for 64-bit balenaOS, armhf for 32-bit)
# The package will automatically pull in required runtime dependencies
RUN ARCH=$(dpkg --print-architecture) && \
    wget -O /tmp/snapclient.deb \
    "https://github.com/snapcast/snapcast/releases/download/v${SNAPCAST_VERSION}/snapclient_${SNAPCAST_VERSION}-1_${ARCH}_bookworm.deb" && \
    install_packages /tmp/snapclient.deb && \
    rm /tmp/snapclient.deb

ENTRYPOINT ["/usr/bin/snapclient"]
