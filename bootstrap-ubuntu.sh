#!/usr/bin/zsh

# ========= check to be on zsh =========
if [[ $SHELL != *zsh ]]; then
  echo "Please use this script on the zsh shell"
  exit 1
fi

# ========= install dependencies =========
sudo apt update

sudo apt install curl tmux thefuck -y
sudo snap install --beta nvim --classic

if ! rust --version  &> /dev/null; then
    echo "========= installing rust"
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi

# ========= check for additional dependencies =========
function check_command() {
    if ! $1 $2  &> /dev/null
    then
        echo "$1 could not be found, please install it prior to continue"
        exit 1
    fi
}

# use nvm
#check_command node
#check_command npm
# use sdkman
#check_command java
#check_command mvn

check_command docker --version
check_command tmux -V
check_command nvim --version
check_command curl --version

# ========= setup =========

echo "========= zsh start"

if ! [ -d ~/.oh-my-zsh ]; then
    echo "========= Installing oh my zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    echo "========= Cloning theme"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    echo "========= Cloning autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-autocomplete ]; then
    echo "========= Cloning autocomplete"
    git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git ~/.oh-my-zsh/custom/plugins/zsh-autocomplete
fi

ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zsh/p10k.zsh ~/.p10k.zsh
ln -sfn ~/.dotfiles/zsh/os ~/.oh-my-zsh/custom/os

echo "========= zsh done"

ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
echo "========= git done"

echo "========= tmux start"
if ! [ -d ~/.tmux/plugins/tpm ]; then
    echo "========= cloning Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
echo "========= tmux done"


echo "========= nvim start"

if ! [ -d ~/.local/share/nvim/site/pack/packer ]; then
    echo "========= Cloning packer"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

ln -sfn ~/.dotfiles/nvim ~/.config/nvim
echo "========= nvim done"
