_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

GCLOUD_COMPLETETION=$HOME/.local/google-cloud-sdk/completion.zsh.inc
if [ -f $GCLOUD_COMPLETETION ]; then
  . ${GCLOUD_COMPLETETION}
fi

if command -v terraform > /dev/null; then
  complete -o nospace -C /usr/bin/terraform terraform
  complete -C /usr/bin/terraform terraform
fi

