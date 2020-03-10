#!/bin/sh
set -eo pipefail

test -d unpacked || echo 'Wrong dir/You must run download-unpack-latest.sh first'
test -d unpacked

./inner-scripts/install-common.sh

echo 'Systemd specific stuff:'
echo '- Installing /opt/google/endpoint-verification/bin/oneshot.sh'
install systemd/oneshot.sh /opt/google/endpoint-verification/bin/oneshot.sh
echo '- Installing /etc/systemd/system/endpoint-verification.service'
install systemd/endpoint-verification.service /etc/systemd/system/endpoint-verification.service
echo '- Systemctl daemon reload'
systemctl daemon-reload
echo '- Enable endpoint-verification.service (after sockets) & Start now'
systemctl enable --now endpoint-verification
echo 'OK'

