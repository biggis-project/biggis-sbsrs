#!/bin/sh

SECRET=`cat /opt/sbsrs/sbsrs.secret`

java -Dplay.crypto.secret="'$SECRET'" -jar /opt/sbsrs/sbsrs.jar
