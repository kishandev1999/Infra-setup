#!/bin/bash
sudo apt update
sudo apt install python3-pip -y
sudo apt install sqlite3 -y
sudo apt install python3.10-venv -y
sudo apt install libpq-dev -y
pip install "apache-airflow[postgres]==2.5.1" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.5.1/constraints-3.7.txt"
sudo apt install postgresql postgresql-contrib -y

airflow db init

#sudo -i -u postgres
#sudo -i -u postgres psql -c "CREATE DATABASE airflow;"
#sudo -i -u postgres psql -c "CREATE USER airflow WITH PASSWORD 'airflow';"
#sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;"

cd /root/airflow

grep sql_alchemy_conn airflow.cfg
#sqlite:////root/airflow/airflow.db


aiflow_initial_db=`grep "sql_alchemy_conn =" /root/airflow/airflow.cfg`
echo "$aiflow_initial_db" | sed 's/sql_alchemy_conn = //g'
database_value=`echo "$aiflow_initial_db" | sed 's/sql_alchemy_conn = //g'`

sed -i 's#$database_value#postgresql+psycopg2://admin_123a:admin_123a@airflow-db.cj0jajqgnaw0.us-east-1.rds.amazonaws.com/airflowdata#g' airflow.cfg

sed -i 's#sqlite:////home/ubuntu/airflow/airflow.db#postgresql+psycopg2://admin_123a:admin_123a@airflow-db.cj0jajqgnaw0.us-east-1.rds.amazonaws.com/airflowdata#g' airflow.cfg

#sed -i 's#SequentialExecutor#LocalExecutor#g' airflow.cfg

airflow db init

airflow users create -u airflow-1234 -f airflow -l airflow -r Admin -p airflow -e airflowi@gmail.com

airflow webserver &

airflow scheduler
