#!/bin/sh
set -eo pipefail

test -d unpacked || echo 'Wrong dir/You must run download-unpack-latest.sh first'
test -d unpacked

./inner-scripts/install-common.sh

EXISTING=$(ls /etc/init.d/endpoint-verification.sh >/dev/null)

echo "Using Google's method for installing the service"
echo '- Installing /etc/init.d/endpoint-verification.sh'
install unpacked/data/etc/init.d/endpoint-verification.sh /etc/init.d/endpoint-verification.sh
echo '- Running Google .deb postinst'
unpacked/control/postinst configure "$EXISTING"

