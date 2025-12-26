#!/usr/bin/env bash
set -e

export NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake .#nixos
