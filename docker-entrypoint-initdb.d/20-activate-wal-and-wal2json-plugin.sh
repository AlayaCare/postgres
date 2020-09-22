#!/bin/bash

# activate wal
cd "${PGDATA}"
sed -ri "s/^#?(wal_level\s*=\s*)\S+/\1logical/" postgresql.conf
sed -ri "s/^#?(max_wal_senders\s*=\s*)\S+/\110/" postgresql.conf
sed -ri "s/^#?(wal_keep_segments\s*=\s*)\S+/\110/" postgresql.conf

# any user with replication capabilities, from any ip can connect and replicate data
echo "host      replication     all     0.0.0.0/0       trust" >> pg_hba.conf
