# [nvim config](https://github.com/offa/nvim-config)

[![ci](https://github.com/offa/nvim-config/actions/workflows/ci.yml/badge.svg)](https://github.com/offa/nvim-config/actions/workflows/ci.yml)
[![GitHub release](https://img.shields.io/github/release/offa/nvim-config.svg)](https://github.com/offa/nvim-config/releases)
[![License](https://img.shields.io/badge/license-GPLv3-yellow.svg)](LICENSE)
![Neovim](https://img.shields.io/badge/nvim-0.11.0+-green.svg)

NeoVim configuration written in Lua using [Plug](https://github.com/junegunn/vim-plug).

## Installation

### Automatic

Use `install.sh` (requires *curl*).

### Manual

```sh
# Ensure config directory
mkdir -p ~/.config/nvim

# Link config
ln -s ./init.lua ~/.config/nvim/init.lua

# Install Plug and Plugins
curl -sfLO ~/.config/nvim/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugUpgrade +PlugInstall +qa!
```
