# dotfiles

# setting up on new machine

## 1. install stow and git
#### if ur machine is not fedora then install stow git according to urs
**sudo dnf install stow git**


## 2. clone your dotfiles
**git clone https://github.com/slikhithreddy22/dotfiles.git ~/dotfiles**

## 3. stow everything
**cd ~/dotfiles**
**stow --target="$HOME" alacritty nvim fish tmux doom**
