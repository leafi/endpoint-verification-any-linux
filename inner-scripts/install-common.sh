#!/bin/sh
set -eo pipefail

test -d unpacked || echo 'Wrong dir/You must run download-unpack-latest.sh first'
test -d unpacked

echo 'Installing common files'

install -d /etc/opt/chrome/native-messaging-hosts
install -d /opt/google/endpoint-verification/bin
install -d /opt/google/endpoint-verification/var/lib

install unpacked/data/etc/opt/chrome/native-messaging-hosts/com.google.secure_connect.native_helper.json /etc/opt/chrome/native-messaging-hosts/com.google.secure_connect.native_helper.json
install unpacked/data/opt/google/endpoint-verification/bin/device_state.sh unpacked/data/opt/google/endpoint-verification/bin/SecureConnectHelper /opt/google/endpoint-verification/bin

echo 'Installed'

