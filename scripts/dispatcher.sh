$SPARK_HOME/bin/spark-class \
    org.apache.spark.deploy.mesos.MesosClusterDispatcher \
    --master ${SPARK_MASTER}  \
    --host ${CURRENT_IP} \
    --port 7070 \
    --webui-port 4040 \
    --conf spark.master=${SPARK_MASTER}  \
    --conf spark.mesos.mesosExecutor.cores=${MESOS_EXECUTOR_CORE}  \
    --conf spark.mesos.executor.docker.image=${SPARK_IMAGE}  \
    --conf spark.mesos.executor.docker.forcePullImage=false  \
    --conf spark.mesos.executor.home=/spark  \
    --conf spark.driver.host=${CURRENT_IP}  \
    --conf spark.driver.bindAddress=127.0.0.1         \
    --conf spark.executor.extraClassPath=/spark/custom/lib/*  \
    --conf spark.driver.extraClassPath=/spark/custom/lib/*  \
    --conf spark.master.rest.enabled=true  
