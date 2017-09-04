#!/bin/bash
#
# Copyright 2016 - 2017 offa
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

RC_DIR=${HOME}
NVIM_CONF_DIR=${RC_DIR}/.config/nvim
PLUG_VIM_REPO=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


function ok() {
    echo -e "\e[0;32m[ OK ]\e[0m\t$1"
}

function fail() {
    echo -e "\e[0;31m[FAIL]\e[0m\t$1"
    exit 1
}

function info() {
    echo -e "[INFO]\t$1"
}

function backupIfExisting() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        info "'$1' already exists - creating backup"
        mv "$1" "$1.backup"
    fi
}

function createLink {
    ln -s -f $1 $2

    if [ "$?" -ne 0 ]; then
        fail "Unable to create link $1 --> $2"
    fi
}

function linkConfig {
    createLink $PWD/$1 ${RC_DIR}/$1
}

function installPluginManager() {
    curl -sfLo ${NVIM_CONF_DIR}/autoload/plug.vim --create-dirs ${PLUG_VIM_REPO}

    if [ "$?" -ne 0 ]; then
        fail "Downloading Plugin manager failed"
    fi

}

function checkProgram() {
    if command -v "$1" > /dev/null 2>&1; then
        ok "$1 found"
    else
        fail "$1 not found"
    fi
}


info "Installation of nvim config"

# Ensure onfig directory
mkdir -p ${NVIM_CONF_DIR}

# Check Nvim
checkProgram nvim
checkProgram curl


# Create backup of files if already existing
backupIfExisting ${RC_DIR}/.vimrc
backupIfExisting ${RC_DIR}/.vimrc.bundles
backupIfExisting ${NVIM_CONF_DIR}/init.vim


# Create links
linkConfig .vimrc
linkConfig .vimrc.bundles
createLink ${RC_DIR}/.vimrc ${NVIM_CONF_DIR}/init.vim
ok "Links created"


# Install Plugin Manager
installPluginManager
ok "Plugin manager downloaded"


# Install Plugins
nvim +PlugUpgrade +PlugInstall +qa!
ok "Plugins installed"


info "Done"

