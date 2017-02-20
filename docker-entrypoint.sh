#!/bin/sh

SECRET=`cat /opt/sbsrs/sbsrs.secret`

java -Dplay.crypto.secret="'$SECRET'" -Dsbsrs.kafkaServer="$KAFKA_SERVER" -jar /opt/sbsrs/sbsrs.jar
