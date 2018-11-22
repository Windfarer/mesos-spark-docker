#!/bin/bash

SPARK_MASTER=${SPARK_MASTER:-local}
MESOS_EXECUTOR_CORE=${MESOS_EXECUTOR_CORE:-0.1}
SPARK_IMAGE=${SPARK_IMAGE}

export SPARK_LOCAL_IP=${SPARK_LOCAL_IP:-${PUBLIC_IP:-"127.0.0.1"}}
export SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS:-${SPARK_PUBLIC_DNS:-"127.0.0.1"}}

if [ $ADDITIONAL_VOLUMES ];
then
        echo "spark.mesos.executor.docker.volumes: $ADDITIONAL_VOLUMES" >> /spark/conf/spark-defaults.conf
fi

exec $@