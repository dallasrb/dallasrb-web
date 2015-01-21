set -e -x

apt-get install --yes zlib1g-dev libssl-dev libffi-dev libffi6 libyaml-dev

if ! ruby -v | grep 1.9.3-p429; then
  if ! test -f ruby-1.9.3-p429.tar.bz2; then
    wget cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p429.tar.bz2
  fi
  if ! test -f ruby-1.9.3-p429.tar; then
    bunzip2 -k ruby-1.9.3-p429.tar.bz2
  fi
  if ! test -d ruby-1.9.3-p429; then
    tar -x -f ruby-1.9.3-p429.tar
  fi

  cd ruby-1.9.3-p429
  ./configure --disable-install-doc
  make
  make install
  cd ..

  gem update --system
  gem install bundler
fi
