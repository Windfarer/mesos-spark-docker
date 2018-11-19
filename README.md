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
docker run -it --rm --net=host -e CURRENT_IP=<CURRENT_IP> -e SPARK_MASTER="<MESOS_MASTER_URL>" <SPARK_IMAGE> bash
```