#!/bin/sh
set -eo pipefail

INSTALL_PREFIX=/opt/google/endpoint-verification
DEVICE_STATE="$INSTALL_PREFIX/bin/device_state.sh"
DEVICE_ATTRS_FILE="$INSTALL_PREFIX/var/lib/device_attrs"

"$DEVICE_STATE" init >"$DEVICE_ATTRS_FILE"

