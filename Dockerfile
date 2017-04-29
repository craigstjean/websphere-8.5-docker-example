FROM ibmcom/websphere-traditional:8.5.5.11-profile

USER root
RUN apt-get install -y iproute2
USER was

# Create our application datasources
# COPY docker-helpers/ojdbc6.jar /work/ojdbc6.jar
# COPY docker-helpers/installDataSource.py /work/installDataSource.py
# RUN /opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -f /work/installDataSource.py -profileName AppSrv01 -conntype NONE

# Setup our build environment
RUN cd /work; wget http://apache.osuosl.org/maven/binaries/apache-maven-3.2.2-bin.tar.gz; tar xzf apache-maven-3.2.2-bin.tar.gz
ENV JAVA_HOME /opt/IBM/WebSphere/AppServer/java
ENV PATH "${JAVA_HOME}/bin:/work/apache-maven-3.2.2/bin:${PATH}"
COPY docker-helpers/settings.xml /work/settings.xml
# TODO find a better way than hardcoding the host ip...
RUN sed -i 's/HOSTIP/192.168.0.107/' /work/settings.xml

# Copy our application code
COPY docker-hellowebsphere-ear /work/docker-hellowebsphere-ear/
COPY docker-hellowebsphere-web /work/docker-hellowebsphere-web/
COPY pom.xml /work/pom.xml

# Ensure our application code has the correct permissions
USER root
RUN chown -R was /work/docker*
USER was

# Build our application
RUN cd /work; mvn --settings /work/settings.xml package

# Install our application into WebSphere
COPY docker-helpers/installApplication.py /work/installApplication.py
RUN /opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -f /work/installApplication.py -profileName AppSrv01 -conntype NONE

CMD ["/work/start_server"]

