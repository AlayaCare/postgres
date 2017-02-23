FROM postgres:9.4

# See also
# https://github.com/docker-library/postgres/blob/master/9.4/Dockerfile
# https://docs.docker.com/compose/compose-file/#/args

ENV LIQUIDBASE_RELEASE=3.4.1 \
    POSTGRESQL_RELEASE=9.4

RUN    DEBIAN_FRONTEND=noninteractive \
       OS_RELEASE=$(lsb_release -sc) \
    && apt-get update \
    && apt-get install -yq curl \
    && apt-get upgrade -y \
    && curl -L https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /tmp/postgresql.key \
    && apt-key add /tmp/postgresql.key \
    && rm -f /tmp/postgresql.key \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ ${OS_RELEASE}-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && apt-get install -y -o Dpkg::Options::="--force-overwrite" \
                          postgresql-${POSTGRESQL_RELEASE}-postgis-2.3 \
                          postgresql-${POSTGRESQL_RELEASE} \
                          locales-all \
    && locale-gen "en_US.UTF-8" \
    && apt-get clean \
    && printf "\n\n\n\n\n      Done with init.sh. Do not stop this just yet.\n\n\n\n\n"

