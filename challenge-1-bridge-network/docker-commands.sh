# Step 1: Create a custom bridge network
docker network create my-custom-network

# Step 2: Run an Nginx container on the custom network
docker run -d --name nginx-container --network my-custom-network nginx

# Step 3: Run an Alpine container on the same network
docker run -it --rm --name alpine-container --network my-custom-network alpine sh

# Step 4: Test connectivity from Alpine to Nginx (inside Alpine container)
apk add --no-cache curl
curl nginx-container