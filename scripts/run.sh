#!/bin/bash

SPARK_MASTER=${SPARK_MASTER:-local}
MESOS_EXECUTOR_CORE=${MESOS_EXECUTOR_CORE:-0.1}
SPARK_IMAGE=${SPARK_IMAGE}
# CURRENT_IP=$(hostname -i)

sed -i 's;SPARK_MASTER;'$SPARK_MASTER';g' /spark/conf/spark-defaults.conf
sed -i 's;MESOS_EXECUTOR_CORE;'$MESOS_EXECUTOR_CORE';g' /spark/conf/spark-defaults.conf
sed -i 's;SPARK_IMAGE;'$SPARK_IMAGE';g' /spark/conf/spark-defaults.conf
sed -i 's;CURRENT_IP;'$CURRENT_IP';g' /spark/conf/spark-defaults.conf

export SPARK_LOCAL_IP=${SPARK_LOCAL_IP:-${CURRENT_IP:-"127.0.0.1"}}
export SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS:-${SPARK_PUBLIC_DNS:-"127.0.0.1"}}

if [ $ADDITIONAL_VOLUMES ];
then
        echo "spark.mesos.executor.docker.volumes: $ADDITIONAL_VOLUMES" >> /spark/conf/spark-defaults.conf
fi

exec "$@"