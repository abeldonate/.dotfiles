#!/bin/bash

user="abel"	

SYSTEM_PAC=(
	base-devel
	git git-lfs
	yay
	bspwm
	sxhkd
	neovim neovim-plug
	rofi
	compton
	stow
	feh
	polybar
	alacritty kitty
	zsh
	oh-my-zsh
	manjaro-zsh-config
	zathura zathura-pdf-mupdf
	firefox
	dmenu
	networkmanager
	python-pywal
	dunst
	ttf-font-awesome
	rclone
	stalonetray
	maim
	xorg
	xorg-xinput
	xf86-input-libinput
	xorg-xrandr
	networkmanager-dmenu
	xorg-setxkbmap	
	wmctrl
	xorg-xev
	translate-shell
	flameshot
	ranger
	vifm
	alsa-utils
	playerctl
	netctl
	wpa_supplicant
	xorg-xinput
	xdotool
	ttf-hack
	qalculate-gtk
	xclip
	bluez bluez-utils
	ruby
    brightnessctl
	python-pynvim
	texlive-latexrecommended
	texlive-latexextra
)


SYSTEM_AUR=(
    neovim-plug nord-vim vim-airline-themes
	systray-x-git
	betterlockscreen
	i3lock-color	
	brightnessctl
	nerd-fonts-iosevka
	xkb-switch
	python-xlib
	syncthing
	devour
	blueman
)

PROG_PAC=(
    cheese
	brave-browser
    audacity
    discord
    gimp
    simplescreenrecorder
    pdfjam
    telegram-desktop
	inkscape
)

PROG_AUR=(
	whatsdesk
	todoist-nativefier
	spotify spotify-adblock-git spicetify-themes-git spicetify-cli
	google-calendar-nativefier
	thunderbird
	dialect
)

function intro {
    echo "==> Indicate the parts of installation you want to SKIP"
    echo "1  Pacman system packages"
    echo "2  Yay system packages"
    echo "3  Pacman program packages"
    echo "4  Yay program packages"
    read -p "==> " skipped
}

function set_user {
    local answer
    read -p "Non-root user is set as '$user', continue? [Y/n] " answer
    [[ $answer == [Nn] || answer == [Nn][Oo] ]] && exit 1
}

# Recieves the installer and array of packages
function installer() {
    local manager=$1
    shift
    for package in "$@"; do
        echo "Installing $package with $manager"
        if [[ $manager == "pacman" ]]; then
            pacman -S --noconfirm $package
        elif [[ $manager == "yay" ]]; then
            sudo -u $user yay -S --noconfirm $package
        fi
    done
}

if [ $EUID -ne 0 ]; then
   echo "This script must be run as root"
   exit 1
fi
set_user

intro
echo $skipped

[[ -z $(echo $skipped | grep 1) ]] &&
    installer pacman "${SYSTEM_PAC[@]}"

[[ -z $(echo $skipped | grep 2) ]] &&
    installer yay "${SYSTEM_AUR[@]}"

[[ -z $(echo $skipped | grep 3) ]] &&
    installer pacman "${PROG_PAC[@]}"

[[ -z $(echo $skipped | grep 4) ]] &&
    installer yay "${PROG_AUR[@]}"
