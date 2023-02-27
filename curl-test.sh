#!/bin/bash

# Generate a random timeline post
name=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8 ; echo '')
email=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8 ; echo '')@example.com
content=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32 ; echo '')
data="name=$name&email=$email&content=$content"

# Create the timeline post using the POST endpoint
curl -X POST \
  http://localhost:5000/api/timeline_post \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d "$data"
