FROM apache/airflow:2.2.3
WORKDIR /app
USER root

COPY . . 
RUN chown -R airflow /app

USER airflow
RUN pip install -r ./requirements.txt