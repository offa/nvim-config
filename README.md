# [nvim config](https://github.com/offa/nvim-config)

[![ci](https://github.com/offa/nvim-config/actions/workflows/ci.yml/badge.svg)](https://github.com/offa/nvim-config/actions/workflows/ci.yml)
[![GitHub release](https://img.shields.io/github/release/offa/nvim-config.svg)](https://github.com/offa/nvim-config/releases)
[![License](https://img.shields.io/badge/license-GPLv3-yellow.svg)](LICENSE)
![Neovim](https://img.shields.io/badge/nvim-0.12-green.svg)

NeoVim configuration written in Lua.

## Installation

### Prerequisites

- Neovim ≥ 0.12
- Git

### Instructions

```sh
git clone https://github.com/offa/nvim-config ~/.config/nvim/
```

Then start Neovim. On first launch, [lazy.nvim](https://github.com/folke/lazy.nvim) is cloned and all plugins are installed automatically.

You can also sync the plugins headless, before the first interactive launch:

```sh
nvim --headless "+Lazy! sync" +qa
```
