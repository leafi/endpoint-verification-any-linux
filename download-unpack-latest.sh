#!/bin/sh
set -eo pipefail

./inner-scripts/check-requirements.sh

test ! -d unpacked || rm -rf unpacked
mkdir unpacked

echo 'Downloading .deb (unstable version - it is simpler)'

echo 'Downloading https://packages.cloud.google.com/apt/dists/endpoint-verification-unstable/main/binary-amd64/Packages' >>unpacked/download-log.txt
curl https://packages.cloud.google.com/apt/dists/endpoint-verification-unstable/main/binary-amd64/Packages >unpacked/Packages 2>>unpacked/download-log.txt || echo 'failed - check unpacked/download-log.txt'
# show version to user
grep Version unpacked/Packages
# grab .deb url
DEB_URL="https://packages.cloud.google.com/apt/$(grep Filename unpacked/Packages | sed -e 's/Filename: //g' | grep 'endpoint-verification_')"
echo "Downloading ${DEB_URL}" >>unpacked/download-log.txt
curl -o unpacked/endpoint-verification.deb "${DEB_URL}" 2>>unpacked/download-log.txt || echo 'failed - check unpacked/download-log.txt'

echo 'Unpacking'
mkdir -p unpacked/endpoint-verification
pushd unpacked/endpoint-verification >/dev/null
ar x ../endpoint-verification.deb

mkdir ../control ../data

echo 'Unpacking control.tar.gz'
cd ../control
tar -zxf ../endpoint-verification/control.tar.gz

echo 'Unpacking data.tar.gz'
cd ../data
tar -zxf ../endpoint-verification/data.tar.gz

echo 'Checking data/etc/init.d/endpoint-verification against known sum'
cksum etc/init.d/endpoint-verification
KNOWN_SUM='2640281529 920 etc/init.d/endpoint-verification'
cksum etc/init.d/endpoint-verification | grep "$KNOWN_SUM" >/dev/null || echo "ERROR: cksum endpoint-verification does NOT match '$KNOWN_SUM';\nERROR: Cannot guarantee install-systemd.sh will do the right thing!"
# error out if no match
cksum etc/init.d/endpoint-verification | grep "$KNOWN_SUM" >/dev/null

echo 'Check known files'
ls etc/opt/chrome/native-messaging-hosts/com.google.endpoint_verification.api_helper.json >/dev/null
ls etc/opt/chrome/native-messaging-hosts/com.google.secure_connect.native_helper.json >/dev/null
ls usr/lib/mozilla/native-messaging-hosts/com.google.endpoint_verification.api_helper.json >/dev/null
ls opt/google/endpoint-verification/bin/apihelper >/dev/null
ls opt/google/endpoint-verification/bin/device_state.sh >/dev/null
ls opt/google/endpoint-verification/bin/SecureConnectHelper >/dev/null

# echo 'Patch device_state.sh for OS_VERSION support (extract from kernel uname)'
# sed -i.original -e 's/set -u/set -u ; OS_VERSION="$(\/usr\/bin\/uname -v | sed -e s\/.*SMP\\ PREEMPT\\ \/\/g)"/g' opt/google/endpoint-verification/bin/device_state.sh
echo 'Patch device_state.sh for OS_VERSION support (hardcode 18.04)'
sed -i.original -e 's/set -u/set -u ; OS_VERSION="18.04"/g' opt/google/endpoint-verification/bin/device_state.sh

popd

echo "OK!"
echo ' '
echo 'Now run sudo ./install-systemd.sh or sudo ./install-rc.d-systemctl.sh.'

