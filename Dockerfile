FROM apache/airflow:2.2.3-python3.9
WORKDIR /app
USER root

COPY . . 

RUN chown -R airflow /app

USER airflow
# RUN pip install -r ./app/src/config/requirements.txt