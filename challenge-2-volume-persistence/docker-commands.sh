# Step 1: Create a named volume
docker volume create mysql_data

# Step 2: Run MySQL with the named volume
docker run -d \
  --name mysql-db \
  -e MYSQL_ROOT_PASSWORD=mysecretpassword \
  -e MYSQL_DATABASE=testdb \
  -v mysql_data:/var/lib/mysql \
  mysql:8.0

# Step 3: Connect to MySQL and create test data
docker exec -it mysql-db mysql -uroot -pmysecretpassword

# Step 4: Stop and remove the container (but keep the volume)
docker stop mysql-db
docker rm mysql-db

# Step 5: Create a new container using the same volume
docker run -d \
  --name mysql-db-new \
  -e MYSQL_ROOT_PASSWORD=mysecretpassword \
  -v mysql_data:/var/lib/mysql \
  mysql:8.0

# Step 6: Verify data persistence
docker exec -it mysql-db-new mysql -uroot -pmysecretpassword -e "USE testdb; SELECT * FROM test_table;"