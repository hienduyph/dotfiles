
input_fonts() {
  _TMP_FILE=/tmp/font_dl.zip
  rm -f ${_TMP_FILE}
  url="https://input.djr.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email="
  dir=$HOME/.local/share/fonts/
  echo "Downloading"
  curl -fsSL -o $_TMP_FILE $url
  unzip $_TMP_FILE -d /tmp
  echo "Extra"
  cp -r /tmp/Input_Fonts/InputMono  /tmp/Input_Fonts/InputSans /tmp/Input_Fonts/InputSerif $dir
  echo "Done"
}


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
