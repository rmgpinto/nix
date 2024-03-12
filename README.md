# Personal Nix Setup

This is my personal nix to setup my computer from scratch.
Instructions are below.

## Install xcode developer tools

```bash
xcode-select --install
```

## Clone this repo

```bash
mkdir -p dev/personal && cd $_
git clone https://github.com/rmgpinto/nix.git
cd nix
./setup.sh
```

## Setup git
```bash
gh auth login
gh auth setup-git
```

## Setup raycast
Load `config/raycast.rayconfig` into Raycast

## Setup 1password
```bash
op account add --address my.1password.com --signin
```
