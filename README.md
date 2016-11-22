# [nvim config](https://github.com/offa/nvim-config)

[![GitHub release](https://img.shields.io/github/release/offa/nvim-config.svg)](https://github.com/offa/nvim-config/releases)
[![License](https://img.shields.io/badge/license-Apache2.0-yellow.svg)](LICENSE)

This is a fork of the great Spf13-vim distribution. It targets on Neovim and uses vim-plug as plugin manager.


## Installation

***After cloning*** (or downloading) the repository ***run*** the **`install.sh`** script *(requires `curl`)*.


### Manual Installation

1. Create these symlinks:
 1. `~/.vimrc`
 1. `~/.vimrc.before`
 1. `~/.vimrc.bundles`
1. Symlink `~/.config/nvim/init.vim` to `~/.vimrc`
1. Download and install *Vim-Plug*
1. Run `nvim +PlugInstall` to install the plugins


## Updating

| *Update of …*       |                     |                 |
|--------------------:|:-------------------:|:---------------:|
| | | |
| **Config files:**   | `git pull`          | -               |
| **Plugins:**        | `nvim +PlugUpdate`  | `:PlugUpdate`   |
| **Plugin Manager:** | `nvim +PlugUpgrade` | `:PlugUpgrade`  |



## Credits

Thanks to the *Spf13-Vim* project and all it's contributors.


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
