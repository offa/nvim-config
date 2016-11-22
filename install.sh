#!/bin/bash
#
# Copyright 2016 offa
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


function fail() {
    echo "$1"
    exit 1
}

function backupIfExisting() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo "'$1' already existing - create backup"
        mv "$1" "$1.backup"
    fi
}

function createLink {
    ln -s -f $1 $2

    if [ "$?" -ne 0 ]; then
        fail "Unable to create link link $1 --> $2"
    fi
}

function linkConfig {
    createLink $PWD/$1 ${RC_DIR}/$1
}


# Create backup of files if already existing
backupIfExisting ${RC_DIR}/.vimrc
backupIfExisting ${RC_DIR}/.vimrc.before
backupIfExisting ${RC_DIR}/.vimrc.bundles
backupIfExisting ${NVIM_CONF_DIR}/init.vim

# Create links
linkConfig .vimrc
linkConfig .vimrc.before
linkConfig .vimrc.bundles
createLink ${RC_DIR}/.vimrc ${NVIM_CONF_DIR}/init.vim


# Install Plugin Manager
curl -fLo ${NVIM_CONF_DIR}/autoload/plug.vim --create-dirs ${PLUG_VIM_REPO}


# Install Plugins
nvim +PlugUpgrade +PlugInstall +qa!

