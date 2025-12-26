#!/usr/bin/env bash
set -e

# Goto the directory this executable is located in
PROJECT_DIR=$(dirname "$(realpath $0)")
cd $PROJECT_DIR

export NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake .#nixos

./dotfiles/sync.sh
