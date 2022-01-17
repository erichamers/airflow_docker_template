# Docker Airflow Template

Template for creating projects with airflow and docker.

## Running the application

You can run the application using docker or on the host.

### Running on docker

```
docker-compose up airflow-init
docker-compose up
```

### Running on host

```
./scripts/setup.sh
. ./venv/bin/activate
airflow standalone
```

Once everything is set and running you can access webserver on `localhost:8080`

### Todo

- Package application;
- Create cli for using the template;
