#FROM hortonworks/ambari-base:7.2-v7
FROM abhinavsinha001/ambari-base:v0.0.1-test
MAINTAINER Abhinav

# add ambari repo
ADD ambari.repo /etc/yum.repos.d/

RUN yum install -y  ambari-agent && yum clean all
RUN find /etc/rc.d/rc* -name "*ambari-agent" | xargs -r rm -v

# add a custom folder to the hadoop classpath
RUN mkdir -p /usr/lib/hadoop/lib
ENV HADOOP_CLASSPATH /data/jars/*:/usr/lib/hadoop/lib/*

ADD public-hostname.sh /etc/ambari-agent/conf/public-hostname.sh
ADD internal-hostname.sh /etc/ambari-agent/conf/internal-hostname.sh
RUN sed -i "/\[agent\]/ a public_hostname_script=\/etc\/ambari-agent\/conf\/public-hostname.sh" /etc/ambari-agent/conf/ambari-agent.ini
RUN sed -i "/\[agent\]/ a hostname_script=\/etc\/ambari-agent\/conf\/internal-hostname.sh" /etc/ambari-agent/conf/ambari-agent.ini

# do not use the docker0 interface
#RUN ls /usr/lib/ambari-agent/lib/ambari_agent/
RUN sed -i "s/\"ifconfig\"/\"ifconfig eth0\"/" /usr/lib/ambari-agent/lib/ambari_agent/Facter.py

# Add jars from packer image
ADD dash-azure-storage-2.2.0.jar /usr/lib/hadoop/lib/
ADD gcs-connector-hadoop3-2.0.0.jar /usr/lib/hadoop/lib/

ADD init/init-agent.sh /opt/ambari-agent/init-agent.sh
RUN chmod u+x /opt/ambari-agent/init-agent.sh

ADD init/ambari-agent.service /etc/systemd/system/ambari-agent.service

RUN systemctl enable ambari-agent

RUN echo DefaultEnvironment=\"JAVA_HOME=$JAVA_HOME\" \"HADOOP_CLASSPATH=$HADOOP_CLASSPATH\" >> /etc/systemd/system.conf

ADD startagent.sh ./

#CMD ["/tmp/startagent.sh"]
