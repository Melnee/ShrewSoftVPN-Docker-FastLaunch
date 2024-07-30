# Use Ubuntu 16.04 as base image
FROM ubuntu:18.04

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    libedit-dev \
    libgtk2.0-dev \
    libpcap-dev \
    x11-apps \
    xauth \
    wget \
    flex \
    bison \
    vim \
    gedit \
    && rm -rf /var/lib/apt/lists/*

# Download and install Shrew Soft VPN Client
RUN wget https://www.shrew.net/download/ike/ike-2.2.1-release.tgz && \
    tar -xvf ike-2.2.1-release.tgz && \
    cd ike && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Set environment variables for X11 forwarding
ENV DISPLAY=:0
ENV XAUTHORITY=/root/.Xauthority

# Set up entry point (bash shell)
CMD ["/bin/bash"]
