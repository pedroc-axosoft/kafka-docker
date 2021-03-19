FROM openjdk:8u282-jre-slim-buster

ARG kafka_version=1.1.0
ARG scala_version=2.12

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY download-kafka.sh start-kafka.sh broker-list.sh create-topics.sh /tmp/

RUN apt update
RUN apt install -y curl jq docker wget net-tools

RUN chmod a+x /tmp/*.sh
RUN mv /tmp/start-kafka.sh /tmp/broker-list.sh /tmp/create-topics.sh /usr/bin
RUN sync && /tmp/download-kafka.sh
RUN tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt
RUN rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka
RUN rm -r /tmp/*

VOLUME ["/kafka"]

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
