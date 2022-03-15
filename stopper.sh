#!/bin/bash

: '
	@Author: Gonçalo Condeço - https://github.com/GoncaloAC
'

source common.sh

if type mysql >/dev/null 2>&1
    then
        sudo /etc/init.d/mysql stop > /dev/null 2>&1
        tell 3 "MySQL is now stopped."
    else
        error 0 "MySQL is not installed."
fi

if type postgresql >/dev/null 2>&1
    then 
        sudo service postgresql stop
        tell 3 "PostgresSQL is now stopped."
    else
        error 0 "PostgresSQL is not installed."
fi

if type mongo >/dev/null 2>&1
    then
        sudo service mongodb stop > /dev/null 2>&1
        tell 3 "MongoDB is now stopped."
    else
        error 0 "MongoDB is not installed."
fi

if redis-server -v >/dev/null 2>&1
    then
        sudo service redis-server stop > /dev/null 2>&1
        tell 3 "Redis is now stopped."
    else
        error 0 "Redis is not installed."
fi

if type cassandra >/dev/null 2>&1
    then
        sudo service cassandra stop > /dev/null 2>&1
        tell 3 "Apache Cassandra is now stopped."
    else
        error 0 "Apache Cassandra is not installed."
fi

if type neo4j >/dev/null 2>&1
    then
        sudo service neo4j stop > /dev/null 2>&1
        tell 3 "Neo4j is now stopped."
    else
        error 0 "Neo4j is not installed."
fi