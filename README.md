```
#/etc/default/mesos-master

PORT=5050
ZK=`cat /etc/mesos/zk`
```

```
#/etc/default/mesos-slave

MASTER=`cat /etc/mesos/zk`
ISOLATION=cgroups/cpu,cgroups/mem,docker/runtime,filesystem/linux
```

```
# /etc/mesos-slave/containerizers

docker,mesos
```

```
# /etc/mesos-slave/executor_registration_timeout

5mins
```

```
docker run -it --rm --net=host --pid=host -e TINI_SUBREAPER=true -e CURRENT_IP=<current_ip> -e SPARK_MASTER="<mesos_addr>"   -e SPARK_IMAGE="<docker_image_tag>"   -e PYSPARK_DRIVER_PYTHON=python3  <docker_image_tag> bash
```