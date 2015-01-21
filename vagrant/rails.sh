set -e -x

apt-get install --yes build-essential nodejs

cd /vagrant
bundle install --binstubs

cat << EOF > /etc/profile.d/rails_secret.sh
#!/bin/bash

export SECRET_TOKEN=thisisthesecrettokenthatyouneed
EOF
chmod 644 /etc/profile.d/rails_secret.sh

rake db:create db:migrate
