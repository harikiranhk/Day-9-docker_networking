# Step 1: Run a simple web server
docker run -d --name webserver nginx

# Step 2: Get the container's IP address
CONTAINER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' webserver)
echo "Container IP: $CONTAINER_IP"

# Step 3: Run another container and communicate with the web server by IP
docker run --rm alpine sh -c "apk add --no-cache curl && curl -s $CONTAINER_IP"