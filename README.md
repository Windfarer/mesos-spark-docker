```
echo "PORT=5050
ZK=`cat /etc/mesos/zk`" > /etc/default/mesos-master
```

```
echo "MASTER=`cat /etc/mesos/zk`
ISOLATION=cgroups/cpu,cgroups/mem,docker/runtime,filesystem/linux" > /etc/default/mesos-slave
```

```
echo "docker" > /etc/mesos-slave/containerizers
```

```
echo "5mins" > /etc/mesos-slave/executor_registration_timeout
```

```
docker run -it --rm --net=host -e PUBLIC_IP=<PUBLIC_IP> -e SPARK_MASTER="<MESOS_MASTER_URL>" <SPARK_IMAGE> bash
```