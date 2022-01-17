#!/usr/bin/env bash

ROOT_FOLDER=$(dirname $(builtin cd $(dirname $0); pwd))
SRC_FOLDER=$ROOT_FOLDER/src
AIRFLOW_HOME=$SRC_FOLDER/local
LOCAL_CONFIG=$AIRFLOW_HOME/config

if ! [ -d $AIRFLOW_HOME ]; then
    mkdir $AIRFLOW_HOME $LOCAL_CONFIG $AIRFLOW_HOME/dags
fi

VENV=$ROOT_FOLDER/venv

if [ -d $VENV ]; then
    rm -rf $VENV
fi

printf "Creating python virtual environment\n"
python -m venv $VENV

echo "export AIRFLOW_HOME=$AIRFLOW_HOME" >> $VENV/bin/activate
echo "export AIRFLOW_CONFIG=$LOCAL_CONFIG/airflow.cfg" >> $VENV/bin/activate

AIRFLOW_VERSION=2.2.3
PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"

CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

printf "\nInstalling apache-airflow\n\n"
$VENV/bin/pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
$VENV/bin/pip install -r ./requirements.txt

printf "\nInitializing airflow\n\n"
$VENV/bin/python -m airflow db init
$VENV/bin/python -m airflow users create \
          --username admin \
          --firstname eric \
          --lastname hamers \
          --role Admin \
          --email admin@example.org \
          --password admin

sed -i 's/load_examples = True/load_examples = False/g' $LOCAL_CONFIG/airflow.cfg
sed -i 's/expose_config = False/expose_config = True/g' $LOCAL_CONFIG/airflow.cfg

cp $SRC_FOLDER/dags/example_dag.py $AIRFLOW_HOME/dags/example_dag.py

printf "\nInstallation Finished!\n\n"