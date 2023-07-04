#!/bin/sh -e

url="https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
wget -q "${url}" -O "/tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
currentPwd="$(pwd)"
cd /tmp/
tar xzf "kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
cp "kafka-server-start.sh" "./kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin/"
cd "kafka_${SCALA_VERSION}-${KAFKA_VERSION}/libs"
rm slf4j-log4j12*
rm log4j*
wget -q https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j-impl/2.20.0/log4j-slf4j-impl-2.20.0.jar
wget -q https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.20.0/log4j-api-2.20.0.jar
wget -q https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.20.0/log4j-core-2.20.0.jar
wget -q https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-1.2-api/2.20.0/log4j-1.2-api-2.20.0-sources.jar
cd ../..
rm -rf "kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
tar czf "kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" "kafka_${SCALA_VERSION}-${KAFKA_VERSION}"
cd "${currentPwd}"