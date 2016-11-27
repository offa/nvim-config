# [nvim config](https://github.com/offa/nvim-config)

[![GitHub release](https://img.shields.io/github/release/offa/nvim-config.svg)](https://github.com/offa/nvim-config/releases)
[![License](https://img.shields.io/badge/license-Apache2.0-yellow.svg)](LICENSE) ![Neovim](https://img.shields.io/badge/nvim-0.1.5+-green.svg)

This is a [Spf13-vim](https://github.com/spf13/spf13-vim) based config for [**Neovim**](https://neovim.io/) using [**vim-plug**](https://github.com/junegunn/vim-plug) als plugin manager.


## Installation

*After cloning* (or downloading) the repository ***run*** the **`install.sh`** script *(requires `curl`)*.


### Manual Installation

1. Create these symlinks:
 1. `~/.vimrc`
 1. `~/.vimrc.before`
 1. `~/.vimrc.bundles`
1. Symlink `~/.config/nvim/init.vim` to `~/.vimrc`
1. Download and install [**vim-plug**](https://github.com/junegunn/vim-plug)
1. Run `nvim +PlugInstall` to install the plugins


## Updating

| *Update of …*       |                     |                 |
|--------------------:|:-------------------:|:---------------:|
| | | |
| **Config files:**   | `git pull`          | -               |
| **Plugins:**        | `nvim +PlugUpdate`  | `:PlugUpdate`   |
| **Plugin Manager:** | `nvim +PlugUpgrade` | `:PlugUpgrade`  |


## Customization

The are *optional* `*.local` files for customization (*italic*); those in bold are provided. All configurations are loaded in this order:

1. **.vimrc.before**
1. *.vimrc.before.local*
1. **.vimrc.bundles**
1. *.vimrc.bundles.local*
1. **.vimrc**
1. *.vimrc.local*


### Selection of plugin groups

There are many plugins available – but most of the time not all are needed. Therefore it's possible to create a custom selection of plugin groups.

This is done by the `.vimrc.before.local` file:

```
" Custom plugin group selection
let g:spf13_bundle_groups=['general', 'writing', 'deoplete', 'programming', ]
```

To see what groups are available (and what plugins are included by them) have a look into the [.vimrc.bundles](./.vimrc.bundles) file.

**Note:** After changing this settings it's useful to *install* (`:PlugInstal`) new and *cleanup* (`:PlugClean`) old plugins.


### Adding a new plugin

New plugin's are added by a custom `~/.vimrc.bundles.local` file. Run `:PlugInstall` will install them.

**Example:**

```
Plug 'airblade/vim-gitgutter'
```


### Removing old plugins

After a plugin has been removed – either by removing it from `.vimrc.bundles.local` are disabling his *group* a `:PlugClean` is necessary to cleanup it's files.



## Documentation

For detailed description of configurations and plugins referr to the original [Spf13-vim Readme](./README.spf13.md) or it's [project](https://github.com/spf13/spf13-vim). in matters of plugin installations see [**vim-plug**](https://github.com/junegunn/vim-plug).


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
