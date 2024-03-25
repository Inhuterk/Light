#!/bin/sh

random() {
    tr </dev/urandom -dc A-Za-z0-9 | head -c5
    echo
}

gen64() {
    ip64() {
        printf "%04x:%04x:%04x:%04x" $((RANDOM % 65536)) $((RANDOM % 65536)) $((RANDOM % 65536)) $((RANDOM % 65536))
    }
    echo "$1:$(ip64):$(ip64):$(ip64):$(ip64)"
}

install_3proxy() {
    echo "installing 3proxy"
    URL="https://github.com/z3APA3A/3proxy/archive/3proxy-0.8.6.tar.gz"
    wget -qO- $URL | bsdtar -xvf-
    cd 3proxy-3proxy-0.8.6 || { echo "Error: Failed to change directory to 3proxy-3proxy-0.8.6"; exit 1; }
    make -f Makefile.Linux || { echo "Error: Make failed"; exit 1; }
    mkdir -p /usr/local/etc/3proxy/{bin,logs,stat} || { echo "Error: Failed to create directory /usr/local/etc/3proxy/{bin,logs,stat}"; exit 1; }
    cp src/3proxy /usr/local/etc/3proxy/bin/ || { echo "Error: Failed to copy 3proxy binary"; exit 1; }
    cp ./scripts/rc.d/proxy.sh /etc/init.d/3proxy || { echo "Error: Failed to copy proxy.sh script"; exit 1; }
    chmod +x /etc/init.d/3proxy || { echo "Error: Failed to chmod proxy.sh"; exit 1; }
    chkconfig 3proxy on || { echo "Error: Failed to enable 3proxy"; exit 1; }
    cd $WORKDIR || { echo "Error: Failed to change directory to $WORKDIR"; exit 1; }
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

$(awk -F "/" '{print "allow " $1 "\n" \
"proxy -6 -n -a -p " $4 " -i " $3 " -e "$5"\n" \
"flush\n"}' "${WORKDATA}")
EOF
}

gen_proxy_file_for_user() {
    awk -F "/" '{print $3 ":" $4 }' "${WORKDATA}" > proxy.txt
}

upload_proxy() {
    local PASS=$(random)
    zip --password $PASS proxy.zip proxy.txt
    echo "Proxy is ready! Format IP:PORT"
    echo "Password: ${PASS}"
}

gen_data() {
    seq $FIRST_PORT $LAST_PORT | while read port; do
        echo "$IP4:$port/$(gen64 $IP6)"
    done
}

gen_iptables() {
    awk -F "/" '{print "iptables -I INPUT -p tcp --dport " $5 " -m state --state NEW -j ACCEPT"}' "${WORKDATA}"
}

gen_ifconfig() {
    awk -F "/" '{print "ifconfig eth0 inet6 add " $6 "/64"}' "${WORKDATA}"
}

echo "installing apps"
yum -y install gcc net-tools bsdtar zip >/dev/null || { echo "Error: Failed to install dependencies"; exit 1; }

install_3proxy

echo "working folder = /home/proxy-installer"
WORKDIR="/home/proxy-installer"

# Check if the directory already exists
if [ ! -d "$WORKDIR" ]; then
    mkdir $WORKDIR || { echo "Error: Failed to create directory $WORKDIR"; exit 1; }
fi

cd $WORKDIR || { echo "Error: Failed to change directory to $WORKDIR"; exit 1; }

IP4=$(curl -4 -s icanhazip.com)
IP6=$(curl -6 -s icanhazip.com | cut -f1-4 -d':')

echo "Internal ip = ${IP4}. External sub for ip6 = ${IP6}"

echo "How many proxy do you want to create? Example 500"
read COUNT

FIRST_PORT=22000
LAST_PORT=22099

gen_data > $WORKDIR/data.txt
gen_iptables > $WORKDIR/boot_iptables.sh
gen_ifconfig > $WORKDIR/boot_ifconfig.sh
chmod +x ${WORKDIR}/boot_*.sh /etc/rc.local

gen_3proxy > /usr/local/etc/3proxy/3proxy.cfg

cat >> /etc/rc.local <<EOF
bash ${WORKDIR}/boot_iptables.sh
bash ${WORKDIR}/boot_ifconfig.sh
ulimit -n 10048
systemctl start 3proxy
EOF

bash /etc/rc.local

gen_proxy_file_for_user

upload_proxy
