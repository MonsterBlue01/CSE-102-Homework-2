docker build -t postgres-sample-db .
docker run -d --name mydb -p 5432:5432 postgres-sample-db
sleep 3
psql -h localhost -p 5432 -U postgres postgres