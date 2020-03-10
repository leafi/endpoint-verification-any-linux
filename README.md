# endpoint-verification-any-linux
This project adapts the Debian/Ubuntu-only 'Endpoint Verification' native helper for any Linux distro by manually downloading the latest .deb, patching device_state.sh to hardcode OS_VERSION to `18.04` (the script can only detect versions for Debian or Ubuntu), and installing the system service and Google Chrome/Chromium native message helper application.

# Using it
1. Clone or download this repo
2. `cd` to the root of this repo
3. Run ./download-unpack-latest.sh
4. If this succeeds, run `sudo ./install-systemd.sh` on e.g. Arch Linux and other systemd-using distros, or `sudo ./install-rc.d-systemctl.sh` to use Google's built-in install script on distributions that have `update-rc.d` but use `systemctl .. start` to start services.

The install script will ask you whether you wish to install the Native Messaging helper application for Google Chrome and/or Chromium (they use different paths). It seems to work fine in Chromium.

It should be reasonably easy to adapt this script's approach to other non-Debian Linux operating systems.
