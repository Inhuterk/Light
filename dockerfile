# Use an official Ubuntu base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    libgmp-dev \
    automake \
    zlib1g-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash miner
USER miner
WORKDIR /home/miner

# Download and extract cpuminer
RUN wget https://github.com/Kudaraidee/cpuminer-opt-kudaraidee/releases/download/v1.1.0/cpuminer-opt-kudaraidee-linux.tar.gz && \
    tar -xf cpuminer-opt-kudaraidee-linux.tar.gz && \
    rm cpuminer-opt-kudaraidee-linux.tar.gz

# Set the mining command
CMD ["./cpuminer-avx", "-a", "yespower", "-o", "stratum+tcp://yespower.mine.zergpool.com:6533", "-u", "RFqmNRc3ycwR2UMcx5afpbgCDzHs7gYavX", "-p", "c=RVN", "-x", "zbcpclbx-rotate:2hicb1nxgc3z@p.webshare.io:80"]
