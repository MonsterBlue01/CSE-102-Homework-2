# Check if there is already a container named "mydb" running
if [ "$(docker ps -aq -f name=mydb)" ]; then
    # If the container already exists, stop and delete it first
    docker stop mydb
    docker rm mydb
fi

docker build -t postgres-sample-db .
docker run -d --name mydb -p 5432:5432 postgres-sample-db
sleep 8
psql -h localhost -p 5432 -U postgres postgres