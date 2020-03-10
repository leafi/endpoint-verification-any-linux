#!/bin/sh
set -eo pipefail

test -d unpacked || echo 'Wrong dir/You must run download-unpack-latest.sh first'
test -d unpacked

./inner-scripts/install-common.sh

# postinst script checks for non-empty $2 var, and sees this as reinstall
EXISTING=""
# double negation
test ! -f /etc/init.d/endpoint-verification.sh || EXISTING="existing"

echo "Using Google's method for installing the service"
echo '- Installing /etc/init.d/endpoint-verification.sh'
install unpacked/data/etc/init.d/endpoint-verification.sh /etc/init.d/endpoint-verification.sh
echo '- Running Google .deb postinst'
unpacked/control/postinst configure "$EXISTING"

