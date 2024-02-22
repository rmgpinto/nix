#!/bin/sh

set -e

GREEN='\033[0;32m'

echo "${GREEN}Installing nix..."
if ! command -v nix > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi
echo "${GREEN}Done.\n"

echo "${GREEN}Running nix build..."
nix build .#darwinConfigurations.macos.system --option sandbox false
echo "${GREEN}Done.\n"

echo "${GREEN}Running nix-darwin..."
./result/sw/bin/darwin-rebuild switch --flake .#macos
echo "${GREEN}Done.\n"

echo "${GREEN}Reboot your machine..."
