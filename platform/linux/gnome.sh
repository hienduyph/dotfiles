#!/bin/bash
# auto install extensions
# https://unix.stackexchange.com/questions/617288/command-line-tool-to-install-gnome-shell-extensions
local APP_ROOT="$(dirname "$(readlink -fm "$0")")"

exts=(
  https://extensions.gnome.org/extension/615/appindicator-support/
  https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/
  https://extensions.gnome.org/extension/307/dash-to-dock/
  https://extensions.gnome.org/extension/4451/logo-menu/
  https://extensions.gnome.org/extension/1287/unite/
  https://extensions.gnome.org/extension/19/user-themes/
)

_install_ext() {
  URL=$1
  EXTENSION_ID=$(curl -s $URL| grep -oP 'data-uuid="\K[^"]+')
  echo "Install ${URL} with id ${EXTENSION_ID}"
  VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
  wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
  gnome-extensions install --force ${EXTENSION_ID}.zip
  if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
    busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
  fi
  gnome-extensions enable ${EXTENSION_ID}
  rm ${EXTENSION_ID}.zip
}

echo "Installing Extensions"
for url in "${exts[@]}"; do
  _install_ext $url
done


echo "Restore configs"
dconf load / < $APP_ROOT/dconf/gnome.dconf
dconf load / < $APP_ROOT/dconf/exts.dconf
