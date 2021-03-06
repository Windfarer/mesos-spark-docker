FROM openjdk:8

ENV SPARK_VERSION=2.4.0
ENV HADOOP_VERSION=2.7

ENV OS_DISTRO=debian
ENV OS_CODENAME=stretch

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

ENV SPARK_HOME /spark
ENV PYSPARK_DRIVER_PYTHON python3

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN echo "deb http://repos.mesosphere.io/${OS_DISTRO} ${OS_CODENAME} main" | \
    tee /etc/apt/sources.list.d/mesosphere.list &&\
    apt-get -y update

# fake systemctl
RUN echo exit 0 > /usr/bin/systemctl && chmod +x /usr/bin/systemctl

RUN apt-get -y install mesos
RUN apt-get -y install curl libcurl3-nss

RUN apt-get -y install python3 python3-setuptools python3-pip

RUN wget http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
      && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz 

COPY spark-conf/* /spark/conf/
COPY scripts /scripts

RUN ln -s /spark/bin/* /bin/

ARG SPARK_IMAGE
RUN if [ ! -z ${SPARK_IMAGE} ]; then echo "spark.mesos.executor.docker.image ${SPARK_IMAGE}" >> /spark/conf/spark-defaults.conf; else echo "SPARK_IMAGE must be set with --build-arg during docker build" >&2 && exit 1; fi
ENV SPARK_IMAGE=${SPARK_IMAGE}

CMD "/scripts/dispatcher.sh" 
