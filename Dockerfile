FROM postgres:12.4
MAINTAINER DevOps Team <ops@alayacare.com>

ENV DEBIAN_FRONTEND noninteractive
ENV POSTGRESQL_RELEASE=12
ENV POSTGRES_PASSWORD=postgres

RUN apt-get update -qq \
    && apt-get install -yq curl \
    && apt-get update \
    && apt-get install -y -o Dpkg::Options::="--force-overwrite" \
          postgresql-${POSTGRESQL_RELEASE}-postgis-3 \
          postgresql-${POSTGRESQL_RELEASE}-wal2json \
          locales-all \
    && locale-gen "en_US.UTF-8" \
    && apt-get clean \
    && printf "\n\n\n\n\n      Done with init.sh. Do not stop this just yet.\n\n\n\n\n"

ADD docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
