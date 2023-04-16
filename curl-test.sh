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

# Set variables for endpoint URLs
URL="http://localhost:5000/api/timeline_post"

# Generate a random post content
POST_CONTENT=$(openssl rand -hex 16)

curl -X POST "${POST_URL}" -d "name=sam&email=sam@gmail.com&content=${POST_CONTENT}"

echo "Getting all timeline posts..."
TIMELINE_POSTS=$(curl "${GET_URL}")

# Check if the new post is in the list of timeline posts
echo "Checking if the new post was added..."
if echo "${TIMELINE_POSTS}" | grep "${POST_CONTENT}"; then
    echo "success"
else
    echo "fail"
fi

