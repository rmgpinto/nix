# Personal Nix Setup

This is my personal nix to setup my computer from scratch.
Instructions are below.

## Install xcode developer tools

```bash
xcode-select --install
```

## Clone this repo

```bash
mkdir -p dev/work
mkdir -p dev/personal && cd $_
git clone https://github.com/rmgpinto/nix.git
cd nix
./setup.sh
```

## Setup
1. Login 1Password
2. Setup 1Password CLI
```bash
op account add --address my.1password.com --signin
```
2. Login to GitHub
```bash
gh auth login
gh auth setup-git
```
3.Load `config/raycast.rayconfig` into Raycast
