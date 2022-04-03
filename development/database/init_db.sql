CREATE USER airbalance_db_user WITH PASSWORD 'airbalance_pass';
CREATE DATABASE airbalance_dev_db;
GRANT ALL PRIVILEGES ON DATABASE airbalance_dev_db TO airbalance_db_user;