$SPARK_HOME/bin/spark-class \
    org.apache.spark.deploy.mesos.MesosClusterDispatcher \
    --master ${SPARK_MASTER}  \
    --host ${LIBPROCESS_IP} \
    --port 7070 \
    --webui-port 4040 \
    --properties-file ${SPARK_HOME}/conf/spark-defaults.conf