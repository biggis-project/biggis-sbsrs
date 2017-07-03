# Based on Scala and sbt Dockerfile
# https://github.com/hseeberger/scala-sbt
# Not directly used because we need Scala 2.11

FROM biggis/base:java8-jre-alpine

MAINTAINER JochenLutz

ARG SCALA_VERSION=2.11.8
ENV SCALA_SHORTVERSION=2.11
ENV SBT_VERSION 0.13.9
ENV SBSRS_VERSION=0.2
ENV TARGET=/opt/sbsrs

ARG BUILD_DATE
ARG VCS_REF

LABEL eu.biggis-project.build-date=$BUILD_DATE \
      eu.biggis-project.license="MIT" \
      eu.biggis-project.name="BigGIS" \
      eu.biggis-project.url="http://biggis-project.eu/" \
      eu.biggis-project.vcs-ref=$VCS_REF \
      eu.biggis-project.vcs-type="Git" \
      eu.biggis-project.vcs-url="https://github.com/biggis-project/sensebox-station/SenseBoxSimpleRestServer" \
      eu.biggis-project.environment="dev" \
      eu.biggis-project.version=$SBSRS_VERSION

# Define working directory
WORKDIR $TARGET

# Install curl
RUN \
  set -x && \
  apk --update add --virtual build-dependencies curl && \
  curl -L -o sbsrs.jar https://github.com/biggis-project/sensebox-station/releases/download/SBSRS-v02/sensebox-simple-rest-server-assembly-${SBSRS_VERSION}.jar && \
  dd if=/dev/random bs=32 count=1 | base64 > sbsrs.secret && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ENV PATH $PATH:$TARGET

ADD docker-entrypoint.sh $TARGET

EXPOSE 9100

CMD ["docker-entrypoint.sh"]
