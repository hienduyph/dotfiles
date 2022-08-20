fkill() {
  ps aux | grep  $1 | awk {'print $2'} | xargs kill -9
}

docker_rm_badimg() {
  dk rmi -f $(dk images -f "dangling=true" -q)
}

bqq() {
  if [ -z $1 ] || [ -z $2 ]; then
    echo 'Required table & sql'
    exit 1
  fi
  bq query --destination_table $1 --replace --use_legacy_sql=false $2
}

bqx() {
  if [ -z $1 ] || [ -z $2 ]; then
    echo 'Require table & dest'
    exit 1
  fi
  bq extract --destination_format NEWLINE_DELIMITED_JSON $1 $2
}

gch() {
 git checkout "$(git branch | fzf| tr -d '[:space:]')"
}

go_mod_update() {
  go list -f '{{if not (or .Main .Indirect)}}{{.Path}}{{end}}' -m all | xargs -n 1 bash -c 'echo $0; go get -d $0 || true'
}

git_large_file() {
  git rev-list --objects --all |
    git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
    sed -n 's/^blob //p' |
    sort --numeric-sort --key=2 |
    cut -c 1-12,41- |
    $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

gh_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

_pkg() {
	sudo dnf "$@"
}

_linux_telegram() {
  DST=$1
  DST=${DST:-/opt/Telegram}
  VERSION="$(gh_latest_release telegramdesktop/tdesktop)"
  VERSION=${VERSION#v}
  sudo mkdir -p $DST
  curl -fSL -o /tmp/file.gz "https://github.com/telegramdesktop/tdesktop/releases/download/v${VERSION}/tsetup.${VERSION}.tar.xz"
  sudo tar xf /tmp/file.gz -C $DST --strip-components=1
}

_fedora_wezterm() {
  wezterm_ver="$(gh_latest_release wez/wezterm)"
  fname="$(echo $wezterm_ver | sed 's/-/_/g')"
  echo "Install WezTerm ${wezterm_ver}"
  sudo dnf install -y "https://github.com/wez/wezterm/releases/download/${wezterm_ver}/wezterm-${fname}-1.fedora36.x86_64.rpm"
}

_github_pks() {(
  set -ex
  luals="$(gh_latest_release sumneko/lua-language-server)"
  sudo mkdir -p /opt/LuaLS
  curl -fSsL "https://github.com/sumneko/lua-language-server/releases/download/${luals}/lua-language-server-${luals}-linux-x64.tar.gz" | sudo tar xz -C /opt/LuaLS
  sudo ln -sf /opt/LuaLS/bin/lua-language-server /usr/local/bin/

  sudo curl -fssLo /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/$(gh_latest_release mikefarah/yq)/yq_linux_amd64"
  sudo chmod +x /usr/local/bin/yq

  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
)}

_linux_nvim_nightly() { (set -e
  echo "update nvim nightly"
  TMP_DIR=/tmp/neovim
  rm -rf $TMP_DIR && mkdir -p ${TMP_DIR}
  echo "Downloading"
  curl -fsSL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz | tar xz -C $TMP_DIR --strip-components=1
  DST_DIR=/opt/neovim-nightly
  if [ ! -d $DST_DIR ]; then
    echo "Creating nvim nightly folder"
    sudo mkdir -p ${DST_DIR}
    sudo chown -R $(whoami) ${DST_DIR}
  fi
  echo "Extrating"
  sudo rm -rf ${DST_DIR}/*
  sudo mv $TMP_DIR/* ${DST_DIR}/
  sudo ln -sf ${DST_DIR}/bin/nvim /usr/local/bin/vv
  echo "Done!"
)}

_linux_nvim() { (set -e
  VERSION=$(gh_latest_release neovim/neovim)
  echo "Install latest stable nvim: ${VERSION}"
  TMP_DIR=/tmp/neovim
  rm -rf $TMP_DIR && mkdir -p ${TMP_DIR}
  echo "Downloading"
  curl -fsSL "https://github.com/neovim/neovim/releases/download/${VERSION}/nvim-linux64.tar.gz" | tar xz -C $TMP_DIR --strip-components=1
  DST_DIR=/opt/neovim
  if [ ! -d ${DST_DIR} ]; then
    echo "Create folder first"
    sudo mkdir -p ${DST_DIR}
    sudo chown -R $(whoami) ${DST_DIR}
  else
    sudo rm -rf "${DST_DIR}/*" || true
  fi

  echo "Extrating to ${DST_DIR}"
  sudo mv $TMP_DIR/* ${DST_DIR}/
  sudo ln -sf ${DST_DIR}/bin/nvim /usr/local/bin/nvim
  sudo ln -sf ${DST_DIR}/bin/nvim /usr/local/bin/vim
  echo "Done!"
)}

_fedora_upgrade() {
  sudo dnf update -y && sudo dnf upgrade -y && sudo dnf autoremove -y
}
