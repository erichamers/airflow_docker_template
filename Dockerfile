FROM apache/airflow:2.2.3
ENV PYTHONDONTWRITEBYTECODE=1 
WORKDIR /app
USER root

COPY . . 
RUN chown -R airflow /app

USER airflow