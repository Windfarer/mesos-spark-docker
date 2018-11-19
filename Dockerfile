FROM java:8

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>
MAINTAINER Gezim Sejdiu <g.sejdiu@gmail.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=2.4.0
ENV HADOOP_VERSION=2.7

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN export OS_DISTRO=debian && \
    export OS_CODENAME=jessie && \
    echo "deb http://repos.mesosphere.io/${OS_DISTRO} ${OS_CODENAME} main" | \
    tee /etc/apt/sources.list.d/mesosphere.list &&\
    apt-get -y update

RUN apt-get -y install mesos

RUN apt-get -y install curl

#COPY bde-spark.css /css/org/apache/spark/ui/static/timeline-view.css

ADD https://raw.githubusercontent.com/guilhem/apt-get-install/master/apt-get-install /usr/bin/
RUN chmod +x /usr/bin/apt-get-install

RUN wget http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
      && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      #&& cd /css \
      #&& jar uf /spark/jars/spark-core_2.11-${SPARK_VERSION}.jar org/apache/spark/ui/static/timeline-view.css \
      && cd /

RUN apt-get -y install python3 python3-setuptools python3-pip

RUN apt-get -y install libcurl3-nss

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

COPY spark-conf/* /spark/conf/
COPY scripts /scripts

ENV SPARK_HOME /spark

ENTRYPOINT ["/scripts/run.sh"]

CMD [ "bash" ]
