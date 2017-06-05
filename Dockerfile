# SBT image based on Oracle JRE 8
# Based on https://github.com/1science/docker-sbt

FROM 1science/java:oracle-jre-8
MAINTAINER Lukas Stefaniak <lustefaniak@gmail.com>

ENV SBT_VERSION 0.13.15
ENV SCALA_VERSION 2.12.2
ENV SCALA_VERSION_2_12 2.12.2
ENV SCALA_VERSION_2_10 2.10.6
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV JAVA_OPTS -Xmx2g

# Install sbt
RUN curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /tmp/ && rm -r /usr/local && mv /tmp/sbt/ /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

RUN mkdir -p src/main/scala && echo "object A" > src/main/scala/A.scala && sbt 'set scalaVersion:="'${SCALA_VERSION_2_10}'"' compile && sbt 'set scalaVersion:="'${SCALA_VERSION_2_12}'"' compile && rm -r -f src target project

# Install other goodies
RUN apk update && apk add git openssh

WORKDIR /app
