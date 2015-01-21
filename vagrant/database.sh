set -e -x

apt-get install --yes postgresql-9.3 postgresql-server-dev-9.3

cat << EOF | su - postgres -c psql
CREATE USER dallasrb WITH CREATEDB PASSWORD 'dallasrb';
EOF

cat << EOF > /etc/postgresql/9.3/main/pg_hba.conf
host  all all      127.0.0.1/32 md5
host  all all      ::1/128      md5
local all dallasrb md5
EOF

service postgresql restart
