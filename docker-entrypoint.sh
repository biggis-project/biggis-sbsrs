#!/bin/sh

SECRET=`cat /opt/sbsrs/sbsrs.secret`

### clean up after unclean shutdown
rm RUNNING_PID

java -Dhttp.port=9100 -Dplay.crypto.secret="'$SECRET'" -Dsbsrs.kafkaServer="$KAFKA_SERVER" -jar /opt/sbsrs/sbsrs.jar
