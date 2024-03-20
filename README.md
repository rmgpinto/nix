# Personal Nix Setup

This is my personal nix to setup my computer from scratch.
Instructions are below.

## Install Xcode developer tools and Rosetta

```bash
xcode-select --install
softwareupdate --install-rosetta
```

## Clone this repo and run setup

```bash
mkdir -p dev/work
mkdir -p dev/personal && cd $_
git clone git@github.com:rmgpinto/nix.git
cd nix
./setup.sh
```

## Setup
1. Login 1Password
2. Setup 1Password CLI
```bash
op account add --address my.1password.com --signin
```
3. Load `config/raycast.rayconfig` into Raycast
4. Follow 1Password SSH agent [instructions](https://developer.1password.com/docs/ssh/get-started#step-3-turn-on-the-1password-ssh-agent)
5. Go to `System Preferences -> Privacy & Security -> Full Disk Access` and add Alacritty and VS Code.