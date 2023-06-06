#!/bin/bash
# auto install extensions
# https://unix.stackexchange.com/questions/617288/command-line-tool-to-install-gnome-shell-extensions

exts=(
  https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/
  https://extensions.gnome.org/extension/307/dash-to-dock/
  https://extensions.gnome.org/extension/4451/logo-menu/
  https://extensions.gnome.org/extension/1287/unite/
  https://extensions.gnome.org/extension/19/user-themes/
  https://extensions.gnome.org/extension/841/freon/
  https://extensions.gnome.org/extension/28/gtile/
  https://extensions.gnome.org/extension/5237/rounded-window-corners/
  https://extensions.gnome.org/extension/615/appindicator-support/
)

_install_ext() {
  URL=$1
  EXTENSION_ID=$(curl -s $URL| grep -oP 'data-uuid="\K[^"]+')
  echo "Install ${URL} with id ${EXTENSION_ID}"
  VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
  wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
  gnome-extensions install --force -q ${EXTENSION_ID}.zip
  rm ${EXTENSION_ID}.zip
}

_enable() {
  EXTENSION_ID=$1
  echo "Waiting user accept!!"
  if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
    busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
  fi
  gnome-extensions enable ${EXTENSION_ID}
}

echo "Installing Extensions"
for url in "${exts[@]}"; do
  _install_ext $url
done


