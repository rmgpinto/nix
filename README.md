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