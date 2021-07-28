# [nvim config](https://github.com/offa/nvim-config)

[![GitHub release](https://img.shields.io/github/release/offa/nvim-config.svg)](https://github.com/offa/nvim-config/releases)
[![License](https://img.shields.io/badge/license-Apache2.0-yellow.svg)](LICENSE)
![Neovim](https://img.shields.io/badge/nvim-0.5.0+-green.svg)

This is a [Spf13-vim](https://github.com/spf13/spf13-vim) based config for [**Neovim**](https://neovim.io/) using [**vim-plug**](https://github.com/junegunn/vim-plug) as plugin manager.


## Installation

Clone or download the repository and ***run*** the **`install.sh`** script *(requires `curl`)*.


### Manual Installation

1. Create symlinks:
 1. `~/.vimrc`
 1. `~/.vimrc.bundles`
1. Symlink `~/.config/nvim/init.vim` to `~/.vimrc`
1. Download and install [**vim-plug**](https://github.com/junegunn/vim-plug)
1. Run `nvim +PlugInstall` to install the plugins


## Updating

| *Update of …*       |                     |
|--------------------:|:-------------------:|
| | | |
| **Config files:**   | `git pull`          |
| **Plugins:**        | `nvim +PlugUpdate`  |
| **Plugin Manager:** | `nvim +PlugUpgrade` |


## Customization

The are *optional* `*.local` files for customization (*italic*); those in bold are provided. Configurations is loaded in order:

1. *.vimrc.before.local*
1. **.vimrc.bundles**
1. *.vimrc.bundles.local*
1. **.vimrc**
1. *.vimrc.local*

### Themes

Themes available by default:

- [gruvbox](https://github.com/morhetz/gruvbox) – *Default*
- [onedark](https://github.com/joshdick/onedark.vim)

**Note:** **Truecolor** is enabled by ***default***. If the terminal doesn't support this, it can be disabled (**`.vimrc.local`**):

```vim
set notermguicolors
```


### Selection of plugin groups

It's possible to create a custom selection of plugin groups using the `.vimrc.before.local` file:

```vim
" Custom plugin group selection
let g:spf13_bundle_groups=['general', 'writing', 'deoplete', 'programming', ]
```

To see what groups are available (and what plugins are included by them) have a look into the [.vimrc.bundles](./.vimrc.bundles) file.

**Note:** After changing this settings it's useful to *install* (`:PlugInstall`) new and *cleanup* (`:PlugClean`) old plugins.


### Adding a new plugin

New plugin's are added by a custom `~/.vimrc.bundles.local` file. Run `:PlugInstall` will install them.

**Example:**

```vim
Plug 'bling/vim-bufferline'
```


### Removing old plugins

After a plugin has been removed a `:PlugClean` is necessary to cleanup it's files.


## Credits

Thanks to the [*Spf13-vim*](https://github.com/spf13/spf13-vim) project and all it's contributors.


## License

**Apache 2.0 License**

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
