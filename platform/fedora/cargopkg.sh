#!/usr/bin/env bash
pkgs=(
jwt-cli
)

for pk in "${pkgs[@]}"; do
  echo "Installing $pk"
  cargo install $pk
done

