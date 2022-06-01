#!/bin/bash
WORK_PATH=$(cd $(dirname $0); pwd)
TEMP_PATH=~/workspace/.tmp/${MY_NAME}
echo "WORK_PATH: ${WORK_PATH}"
echo "TEMP_PATH: ${TEMP_PATH}"

sudo apt-get update

if [ ! -d "${TEMP_PATH}" ]; then
   mkdir -p ${TEMP_PATH}
fi
cd ${TEMP_PATH}
if [ ! -d ".config" ]; then
   mkdir .config
fi
if [ ! -d ".tools" ]; then
   mkdir .tools
fi

cd ${TEMP_PATH}/.config
if [ ! -d ".config" ]; then
   mkdir .config
   sudo rm -rf ~/.config
   sudo ln -s $PWD/.config ~/.config
fi
if [ ! -d ".tmux" ]; then
   mkdir .tmux
   sudo rm -rf ~/.tmux
   sudo ln -s $PWD/.tmux ~/.tmux
fi
if [ ! -d ".local" ]; then
   mkdir .local
   sudo rm -rf ~/.local
   sudo ln -s $PWD/.local ~/.local
fi
if [ ! -d ".ipython" ]; then
   mkdir .ipython
   sudo rm -rf ~/.ipython
   sudo ln -s $PWD/.ipython ~/.ipython
fi
if [ ! -d ".pki" ]; then
   mkdir .pki
   sudo rm -rf ~/.pki
   sudo ln -s $PWD/.pki ~/.pki
fi
if [ ! -d ".cache" ]; then
   mkdir .cache
   sudo rm -rf ~/.cache
   sudo ln -s $PWD/.cache ~/.cache
fi

# kicad
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   software-properties-common \
   libcanberra-gtk-module
if [ ! -f "${TEMP_PATH}/.tools/kicad" ]; then
   cd ${WORK_PATH}
   sudo add-apt-repository --yes ppa:kicad/kicad-6.0-releases
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --install-recommends kicad
   echo "kicad install ok" >> ${TEMP_PATH}/.tools/kicad
fi

# tmux
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   tmux \
   vim-gtk 
if [ ! -f "${TEMP_PATH}/.tools/tmux" ]; then
   cd ${WORK_PATH}
   cd tmux
   ln -s $PWD/.tmux.conf ~/.tmux.conf
   ln -s $PWD/.vimrc ~/.vimrc
   echo "export TMUX_PATH=${TEMP_PATH}/tmux" >> ${HOME}/.bashrc
   echo "tmux install ok" >> ${TEMP_PATH}/.tools/tmux
fi

sudo apt-get clean
sudo apt-get autoclean
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf /var/cache/*
sudo rm -rf /var/lib/apt/lists/*
