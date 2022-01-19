# Docker Airflow Template

Template for creating projects with airflow and docker.

The default `docker-compose.yml` file that is provided in the airflow documentation, has some issues (incompatible airflow and python versions for certain commands for example). This repo aims to solve those issues and be just a clone and start working solution.

## Details

### Services:

These are the more relavant services used, not included in the list are the scheduler, triggerer and airflow-init script.

```
postgres:
    - image: postgres:13
    - default_user: airflow
    - default_password: airflow
    - default_db: airflow

redis:
    - image: redis:latest
    - port: 6379

airflow-webserver:
    - port: 8080

airflow-worker:
    - type: celery
```

### Versions:

```
AirflowVersion: 2.2.3
PythonVersion: 3.9.9
```

## Running the application

```

docker-compose up airflow-init
docker-compose up

```

## Todo

- Package application
