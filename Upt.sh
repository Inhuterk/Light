#!/bin/bash

random() {
    tr </dev/urandom -dc A-Za-z0-9 | head -c5
    echo
}

array=(1 2 3 4 5 6 7 8 9 0 a b c d e f)

gen64() {
    ip64() {
        echo "${array[$RANDOM % 16]}${array[$RANDOM % 16]}${array[$RANDOM % 16]}${array[$RANDOM % 16]}"
    }
    echo "$1:$(ip64):$(ip64):$(ip64):$(ip64)"
}

install_3proxy() {
    echo "installing 3proxy"
    URL="https://github.com/z3APA3A/3proxy/archive/3proxy-0.8.6.tar.gz"
    wget -qO- $URL | bsdtar -xvf-
    cd 3proxy-3proxy-0.8.6 || exit
    make -f Makefile.Linux
    mkdir -p /usr/local/etc/3proxy/{bin,logs,stat}
    cp src/3proxy /usr/local/etc/3proxy/bin/
    cp ./scripts/rc.d/proxy.sh /etc/init.d/3proxy
    chmod +x /etc/init.d/3proxy
    chkconfig 3proxy on
    cd "$WORKDIR" || exit
}

gen_3proxy() {
    cat <<EOF
daemon
maxconn 4000
nserver 1.1.1.1
nserver 8.8.4.4
nserver 2001:4860:4860::8888
nserver 2001:4860:4860::8844
nscache 65536
timeouts 1 5 30 60 180 1800 15 60
setgid 65535
setuid 65535
stacksize 6291456 
flush
auth strong

$(gen_data)

EOF
}

gen_data() {
    for ((i=0; i<$COUNT; i++)); do
        echo "Ram:CL:Ram $IP4:$((FIRST_PORT+i))/$(gen64 $IP6)"
    done
}

gen_proxy_file_for_user() {
    cat >proxy.txt <<EOF
$(gen_proxy_data)
EOF
}

gen_proxy_data() {
    for ((i=0; i<$COUNT; i++)); do
        echo "Ram:Ram:$IP4:$((FIRST_PORT+i))"
    done
}

upload_proxy() {
    local PASS=$(random)
    zip --password $PASS proxy.zip proxy.txt
    echo "Proxy is ready! Format LOGIN:PASS:IP:PORT"
    echo "Password: ${PASS}"
}

echo "installing apps"
yum -y install gcc net-tools bsdtar zip >/dev/null

install_3proxy

echo "working folder = /home/proxy-installer"
WORKDIR="/home/proxy-installer"

if [ ! -d "$WORKDIR" ]; then
    mkdir "$WORKDIR" || exit
fi

cd "$WORKDIR" || exit

IP4="192.46.211.32"
IP6=$(curl -6 -s icanhazip.com | cut -f1-4 -d':')

echo "Internal ip = ${IP4}. External sub for ip6 = ${IP6}"

read -p "How many proxies do you want to create? Example: 500 " COUNT

FIRST_PORT=22000
LAST_PORT=22099

echo "Generating $COUNT proxies with ports ranging from $FIRST_PORT to $LAST_PORT..."

gen_3proxy >/usr/local/etc/3proxy/3proxy.cfg

gen_proxy_file_for_user

upload_proxy
