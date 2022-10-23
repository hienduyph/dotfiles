
fkill() {
  ps aux | grep  $1 | awk {'print $2'} | xargs kill -9
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
  curl -s "https://api.github.com/repos/$1/releases" | jq -r 'first | .tag_name'
}

gh_stable_release() {
  curl -s "https://api.github.com/repos/$1/releases/latest" | jq -r '.tag_name'
}

_pkg() {
	sudo dnf "$@"
}

_fedora_upgrade() {
  sudo dnf update -y && sudo dnf upgrade -y && sudo dnf autoremove -y
}

fedora_maintenance() {
  _fedora_upgrade
}

get_docker_ip() {
  echo "$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1)"
}
