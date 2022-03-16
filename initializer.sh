#!/bin/bash

: '
	@Author: Gonçalo Condeço - https://github.com/GoncaloAC
'

source ./common.sh

if type mysql >/dev/null 2>&1
    then
        sudo /etc/init.d/mysql start > /dev/null 2>&1
        tell 0 "MySQL is now running."
    else
        error 0 "MySQL is not installed."
fi

if type postgresql >/dev/null 2>&1
    then 
        sudo service postgresql start
        tell 0 "PostgresSQL is now running."
    else
        error 0 "PostgresSQL is not installed."
fi

if type mongo >/dev/null 2>&1
    then
        sudo service mongodb start > /dev/null 2>&1
        tell 0 "MongoDB is now running."
    else
        error 0 "MongoDB is not installed."
fi

if redis-server -v >/dev/null 2>&1
    then
        sudo service redis-server start > /dev/null 2>&1
        tell 0 "Redis is now running."
    else
        error 0 "Redis is not installed."
fi

if type cassandra >/dev/null 2>&1
    then
        sudo service cassandra start > /dev/null 2>&1
        tell 0 "Apache Cassandra is now running."
    else
        error 0 "Apache Cassandra is not installed."
fi

if type neo4j >/dev/null 2>&1
    then
        sudo service neo4j start > /dev/null 2>&1
        tell 0 "Neo4j is now running."
    else
        error 0 "Neo4j is not installed."
fi