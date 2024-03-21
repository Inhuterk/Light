%%shell
#!/bin/bash

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
rm -rf javaVM
apt-get update \
  && apt --fix-broken install \
  && apt-get install -y \
    libcurl4 \
    libjansson4 \
    wget \
    zip \
    ocl-icd-opencl-dev \
    build-essential \
    libssl-dev \
    libgmp-dev \
    libjansson-dev \
    automake \
    libnuma-dev \
    libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential binutils cmake screen unzip net-tools curl \
  && rm -rf /var/lib/apt/lists/*



./colab
