#!/bin/zsh

# ========= check to be on zsh =========
if [[ $SHELL != *zsh ]]; then
  echo "Please use this script on the zsh shell"
  exit 1
fi

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

ln -sf ~/.dotfiles/git/gitconfig_mac ~/.gitconfig
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


echo "========= karabiner start"

ln -sfn ~/.dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
echo "========= karabiner done"
