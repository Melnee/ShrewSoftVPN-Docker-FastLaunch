# Use Ubuntu 16.04 as base image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    qtcreator \
    qt5-default \
    qt5-qmake \
    cmake \
    libssl-dev \
    libedit-dev \
    x11-apps \
    wget \
    flex \
    bison \
    vim \
    gedit \
    && rm -rf /var/lib/apt/lists/*

COPY /vpn_files /vpn_files  

WORKDIR /shrewsoft_vpn_container

COPY ./ike_github_repo/ike /shrewsoft_vpn_container

ARG USERNAME

RUN sed -i 's_habusnina_${USERNAME}_gI' ./source/qikea/moc_qikea.cpp_parameters && \
    sed -i 's_habusnina_${USERNAME}_gI' ./source/qikec/moc_qikec.cpp_parameters && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DQTGUI=YES -DETCDIR=/etc -DNATT=YES && \
    make && \
    make install && \
    ldconfig && \
    mv /etc/iked.conf.sample /etc/iked.conf 

# Set environment variables for X11 forwarding
ENV DISPLAY=:0
ENV XAUTHORITY=/root/.Xauthority

# Set up entry point (bash shell)
CMD ["/bin/bash"]
