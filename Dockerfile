FROM postgres:9.6
MAINTAINER DevOps Team <ops@alayacare.com>

ENV DEBIAN_FRONTEND noninteractive
ENV POSTGRESQL_RELEASE=9.6
ENV POSTGRES_PASSWORD=api

RUN apt-get update -qq 
RUN apt-get install -yq curl lsb-release
RUN curl -L https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /tmp/postgresql.key
RUN apt-key add /tmp/postgresql.key 
RUN rm -f /tmp/postgresql.key 
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/pgdg.list 
RUN apt-get update 
RUN apt-get install -y -o Dpkg::Options::="--force-overwrite" \
    postgresql-${POSTGRESQL_RELEASE}-postgis-2.3 \
    postgresql-${POSTGRESQL_RELEASE} \
    postgresql-${POSTGRESQL_RELEASE}-wal2json \
    locales-all 
RUN locale-gen "en_US.UTF-8" 
RUN apt-get clean 
RUN printf "\n\n\n\n\n      Done with init.sh. Do not stop this just yet.\n\n\n\n\n"

ADD docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
