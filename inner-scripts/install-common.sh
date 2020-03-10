#!/bin/sh
set -eo pipefail

test -d unpacked || echo 'Wrong dir/You must run download-unpack-latest.sh first'
test -d unpacked

echo 'Installing common files'

install -d /opt/google/endpoint-verification/bin
install -d /opt/google/endpoint-verification/var/lib

install unpacked/data/opt/google/endpoint-verification/bin/device_state.sh unpacked/data/opt/google/endpoint-verification/bin/SecureConnectHelper /opt/google/endpoint-verification/bin

while true; do
	read -p "Install for GOOGLE CHROME? (I will ask about CHROMIUM next) (y or n)  " yn
    case $yn in
        [Yy]* )
            install -d /etc/opt/chrome/native-messaging-hosts
	    install unpacked/data/etc/opt/chrome/native-messaging-hosts/com.google.secure_connect.native_helper.json /etc/opt/chrome/native-messaging-hosts/com.google.secure_connect.native_helper.json
	    break;;
        [Nn]* ) break;;
        * ) echo "Please answer y or n.";;
    esac
done

while true; do
    read -p "Install for CHROMIUM? (y or n)  " yn
    case $yn in
        [Yy]* )
            install -d /etc/chromium/native-messaging-hosts
	    install unpacked/data/etc/opt/chrome/native-messaging-hosts/com.google.secure_connect.native_helper.json /etc/chromium/native-messaging-hosts/com.google.secure_connect.native_helper.json
	    break;;
        [Nn]* ) break;;
        * ) echo "Please answer y or n.";;
    esac
done

echo 'Installed'

