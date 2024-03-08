#!/bin/sh

set -e

GREEN='\033[0;32m'

echo "${GREEN}Go to System Preferences -> Privacy & Security -> Full Disk Access and add Terminal.app\n"
read -p "Press enter to continue"

echo "${GREEN}Installing nix..."
if ! command -v nix > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
echo "${GREEN}Done.\n"

echo "${GREEN}Renaming nix.conf and zshenv files..."
if ! test -L /etc/nix/nix.conf; then
  if test -f /etc/nix/nix.conf; then
    sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
  fi
fi
if ! test -L /etc/zshenv; then
  if test -f /etc/zshenv; then
    sudo mv /etc/zshenv /etc/zshenv.before-nix-darwin
  fi
fi
echo "${GREEN}Done.\n"

echo "${GREEN}Running nix build..."
nix build .#darwinConfigurations.macos.system --option sandbox false --experimental-features 'nix-command flakes'
echo "${GREEN}Done.\n"

echo "${GREEN}Running nix-darwin..."
./result/sw/bin/darwin-rebuild switch --flake .#macos
echo "${GREEN}Done.\n"

echo "${GREEN}Reboot your machine..."
