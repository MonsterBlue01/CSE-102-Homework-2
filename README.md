# PostgreSQL sample database Docker container

This document describes how to use Docker to build and run a container containing PostgreSQL and sample data to quickly configure the database in different environments.

## Prerequisites

- Docker is installed. If it has not been installed, please refer to [Docker official documentation](https://docs.docker.com/get-docker/) to install it.
- SQL files containing sample data, such as `sample_data.sql`, have been prepared.

## Build Docker image

1. Create a new directory and place the SQL file containing the sample data into it.

2. Open the terminal, switch to the directory, and execute the following command to build the Docker image:

    ```bash
    docker build -t postgres-sample-db .
    ```

    After the command is executed, a Docker image named `postgres-sample-db` is created.

## Run Docker container

Execute the following command to start a container based on the `postgres-sample-db` image:

```bash
docker run -d --name mydb -p 5432:5432 postgres-sample-db
```

This command will run a container named `mydb` in the background and map the container's 5432 port to the host's 5432 port.

## Connect to database

After the container is started, you can use the PostgreSQL client to connect to the database. For example, using the `psql` command line client:

```bash
psql -h localhost -p 5432 -U postgres mydb
```

This will connect to the `mydb` database as the `postgres` user.

## Stop and delete containers

If you want to stop the container, you can execute:

```bash
docker stop mydb
```

If you want to delete the container, you can execute:

```bash
docker rm mydb
```

Please note that deleting a container will cause the data in the container to be lost. If you need to persist data, you can use Docker volumes or store the data on the host.