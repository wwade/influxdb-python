#!/usr/bin/env bash

# Check and install fpm if necessary.
check_fpm() {
    fpm --help > /dev/null 2>&1 || ( echo "Installing fpm" && sudo yum install -y gcc libffi-devel ruby-devel rubygems && sudo gem install fpm )
}

check_fpm

set -e
echo "Creating RPMS"

# Cleanup old RPMS.
mkdir ./RPMS > /dev/null 2>&1 || rm -rf ./RPMS/*
rm ./*.rpm > /dev/null 2>&1  || true

# Build new RPMS.
URL="https://github.com/aristanetworks/influxdb-python"
while read line; do
   DEPENDENCIES+="--depends \"$line\" "
done < ./requirements.txt
FPM_ARGS="--log error --url $URL --no-python-dependencies $DEPENDENCIES"

eval "fpm $FPM_ARGS -s python -t rpm ../setup.py"

mv ./*.rpm RPMS/
echo "Created" `ls RPMS`
