#!/bin/bash
# nvim-config - NeoVim config
#
# Copyright (C) 2016-2022  offa
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

RC_DIR=${HOME}
NVIM_CONF_DIR=${RC_DIR}/.config/nvim
PLUG_VIM_REPO=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


ok() {
    echo -e "\e[0;32m[ OK ]\e[0m\t$1"
}

fail() {
    echo -e "\e[0;31m[FAIL]\e[0m\t$1"
    exit 1
}

info() {
    echo -e "[INFO]\t$1"
}

backupIfExisting() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        info "'$1' already exists - creating backup"
        mv "$1" "$1.backup"
    fi
}

createLink() {
    ln -s -f $1 $2

    if [ "$?" -ne 0 ]; then
        fail "Unable to create link $1 --> $2"
    fi
}

linkConfig() {
    createLink "$PWD/$1" "${NVIM_CONF_DIR}/$1"
}

installPluginManager() {
    curl -sfLo ${NVIM_CONF_DIR}/autoload/plug.vim --create-dirs ${PLUG_VIM_REPO}

    if [ "$?" -ne 0 ]; then
        fail "Downloading Plugin manager failed"
    fi
}

checkProgram() {
    if command -v "$1" > /dev/null 2>&1; then
        ok "$1 found"
    else
        fail "$1 not found"
    fi
}


info "Installation of nvim config"

# Check required applications
checkProgram nvim
checkProgram curl

# Ensure config directory
mkdir -p ${NVIM_CONF_DIR}

# Create backup of files if already existing
backupIfExisting ${NVIM_CONF_DIR}/init.lua


# Create links
linkConfig init.lua
ok "Links created"


# Install Plugin Manager
installPluginManager
ok "Plugin manager downloaded"


# Install Plugins
nvim +PlugUpgrade +PlugInstall +qa!
ok "Plugins installed"


info "Done"
