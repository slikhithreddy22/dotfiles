# Dotfiles

My personal configuration files for:

* Neovim
* Alacritty
* Fish
* Tmux
* Hyprland
* Waybar

## Repository Structure

```text
dotfiles/
├── alacritty/
├── fish/
├── hypr/
├── nvim/
├── tmux/
├── waybar/
└── README.md
```

## Backup Existing Configuration

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.config/alacritty ~/.config/alacritty.bak
mv ~/.config/fish ~/.config/fish.bak
mv ~/.config/tmux ~/.config/tmux.bak
mv ~/.config/hypr ~/.config/hypr.bak
mv ~/.config/waybar ~/.config/waybar.bak
```

## Clone

```bash
git clone https://github.com/slikhithreddy22/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## Setup

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/alacritty ~/.config/alacritty
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/tmux ~/.config/tmux
ln -s ~/dotfiles/hypr ~/.config/hypr
ln -s ~/dotfiles/waybar ~/.config/waybar
```

## Fonts

This setup uses **JetBrains Mono Nerd Font**.

Download **JetBrainsMono** from:

https://www.nerdfonts.com/font-downloads

Download the **JetBrainsMono ZIP** file and extract it.

Then install the fonts:

```bash
mkdir -p ~/.local/share/fonts
unzip ~/Downloads/JetBrainsMono*.zip -d /tmp/JetBrainsMono
cp /tmp/JetBrainsMono/*.ttf ~/.local/share/fonts/
fc-cache -fv
```

Verify the font installation:

```bash
fc-match "JetBrainsMono Nerd Font"
```

## Verify

```bash
ls -l ~/.config
```
