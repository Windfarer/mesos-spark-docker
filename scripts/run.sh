#!/bin/bash
if [ $ADDITIONAL_VOLUMES ];
then
        echo "spark.mesos.executor.docker.volumes: $ADDITIONAL_VOLUMES" >> /spark/conf/spark-defaults.conf
fi

exec "$@"