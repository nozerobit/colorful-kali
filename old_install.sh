#!/usr/bin/bash

# Source progress bar
source ./progress_bar.sh
enable_trapping
setup_scroll_area

###########################################
#---------------) Colors (----------------#
###########################################

end="\033[0m\e[0m"
color="\e[0;33m\033[1m"

###########################################
#--------------) Commands (---------------#
###########################################

SECONDS=0
cwd=$(pwd)

#trap ctrl_c INT

#function ctrl_c() {
#        echo -e "\nTrapped CTRL-C\n"
#}

draw_progress_bar 1
echo "[+] Sudo privileges required"
sudo test

draw_progress_bar 5
echo "[!] If an error occurs you can read the log at $cwd/install_log.txt"
echo "[+] Updating package information!"
sudo apt-get update >> install_log.txt 2>&1
if [ $? != 0 ]; then
    cat << EOF
[-] Failed to update packages, please verify that you have an internet connection and/or check if there's a firewall!
[-] Verify if the /etc/apt/sources.list file is configured correctly!
[-] Also verify if you have other sources such as: /etc/apt/sources.list.d/sublime-text.list
EOF
    exit
fi

draw_progress_bar 10
echo "[+] Installing the programs!"
sudo apt-get install -y neofetch wmname manpages-dev i3lock-fancy ffmpeg ffmpegthumbnailer sxiv mpd mpv pcregrep python3-pyqt5 yad bat cargo arandr scrub flameshot arc-theme fzf ripgrep universal-ctags silversearcher-ag fd-find xclip xsel zsh zsh-autosuggestions zsh-syntax-highlighting feh bspwm sxhkd polybar rbenv htop lxappearance python3-pip unclutter meson papirus-icon-theme imagemagick neovim ranger watchman joplin nodejs npm >> install_log.txt 2>&1
if [ $? != 0 ]; then
    cat << EOF
[-] Failed to install some packages, please verify the source.list and check if there's a firewall or an Anti-Virus blocking the traffic!
[-] Also verify if some package names have changed!
EOF
    exit
fi

draw_progress_bar 15
echo "[+] Installing the dependencies!"
sudo apt-get install -y libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 python3-dev libssl-dev libffi-dev build-essential libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev bison flex check libpango-1.0-0 libpango1.0-dev libpangocairo-1.0-0 libcairo2 libglib2.0-dev libgdk-pixbuf-2.0-0 libstartup-notification0 libstartup-notification0-dev libgdk-pixbuf-2.0-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xkb-dev libxcb-randr0-dev libxcb-xinerama0-dev libxcb-util-dev libxcb-cursor-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xrm-dev librsvg2-dev libevent-dev build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git >> install_log.txt 2>&1
if [ $? != 0 ]; then
    cat << EOF
[-] Failed to install some packages, please verify the source.list and check if there's a firewall or an Anti-Virus blocking the traffic!
[-] Failed to install some dependencies, please verify if a package is outdated or if the name has changed!
EOF
    exit
fi

draw_progress_bar 20
# Install rofi version 1.5.4 (The version 1.7.1 has a foreground color issue with drun elements) this version (1.5.4) avoids this issue.
echo "[+] Installing rofi!"
wget https://github.com/davatorium/rofi/releases/download/1.5.4/rofi-1.5.4.tar.gz -O rofi-1.5.4.tar.gz >> install_log.txt 2>&1
if [ -f "rofi-1.5.4.tar.gz" ]; then
    echo "[+] The file rofi-1.5.4.tar.gz was downloaded."
else 
    echo "[-] The file rofi-1.5.4.tar.gz was not downloaded."
    exit
fi
tar -xvf rofi-1.5.4.tar.gz >> install_log.txt 2>&1
cd rofi-1.5.4 >> install_log.txt 2>&1
mkdir build >> install_log.txt 2>&1; cd build >> install_log.txt 2>&1
../configure >> install_log.txt 2>&1
make >> install_log.txt 2>&1
sudo make install >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install rofi!"
    exit
fi
cd $cwd

draw_progress_bar 25
# Install tmux version 3.1c (The version 3.2a has background color issue, the terminal color is different from alacritty) this version (3.1) avoids this issue.
echo "[+] Installing tmux!"
wget https://github.com/tmux/tmux/releases/download/3.1c/tmux-3.1c.tar.gz -O tmux-3.1c.tar.gz >> install_log.txt 2>&1
if [ -f "tmux-3.1c.tar.gz" ]; then
    echo "[+] The file tmux-3.1c.tar.gz was downloaded."
else 
    echo "[-] The file tmux-3.1c.tar.gz was not downloaded."
    exit
fi
tar -xvf tmux-3.1c.tar.gz >> install_log.txt 2>&1
cd tmux-3.1c >> install_log.txt 2>&1
./configure >> install_log.txt 2>&1 && make >> install_log.txt 2>&1
sudo make install >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install tmux!"
    exit
fi
cd $cwd

draw_progress_bar 30
echo "[+] Installing Iosevka Nerd Fonts!"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip -O Iosevka.zip >> install_log.txt 2>&1
if [ -f "Iosevka.zip" ]; then
    echo "[+] Iosevka.zip was downloaded."
else 
    echo "[-] Iosevka.zip was not downloaded."
    exit
fi
unzip Iosevka.zip >> install_log.txt 2>&1
sudo mv *.ttf /usr/share/fonts >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install Isoevka Nerd Fonts!"
    exit
fi
rm *.zip >> install_log.txt 2>&1

draw_progress_bar 35
echo "[+] Creating a swap partition to install alacritty!"
sudo dd if=/dev/zero of=/mnt/swapfile bs=4096 count=2097152 >> install_log.txt 2>&1
sudo chmod 600 /mnt/swapfile >> install_log.txt 2>&1
sudo mkswap /mnt/swapfile >> install_log.txt 2>&1
sudo swapon /mnt/swapfile >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to create a swap partition!"
    echo -e "[!] Delete the /mnt/swapfile and try again."
    echo -e "[i] Command: sudo swapoff /mnt/swapfile && sudo rm -rf /mnt/swapfile"
    exit
fi

draw_progress_bar 40
echo "[+] Installing alacritty (slow)!"
git clone https://github.com/jwilm/alacritty >> install_log.txt 2>&1
cd alacritty >> install_log.txt 2>&1
cargo build --release >> install_log.txt 2>&1 && sudo cp target/release/alacritty /usr/local/bin >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install Alacritty!"
    echo -e "[i] Don't run this script using the alacritty terminal, use another terminal instead."
    echo -e "[i] Make sure that an alacritty terminal is not running on the background."
    exit
fi
cd $cwd

draw_progress_bar 45
echo "[+] Removing the previous swap partition!"
sudo swapoff /mnt/swapfile >> install_log.txt 2>&1
sudo rm -rf /mnt/swapfile >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to delete the swap partition /mnt/swapfile!"
fi

draw_progress_bar 50
echo "[+] Installing picom!"
git clone https://github.com/yshui/picom >> install_log.txt 2>&1
cd picom/ >> install_log.txt 2>&1
git submodule update --init --recursive >> install_log.txt 2>&1
meson --buildtype=release . build >> install_log.txt 2>&1
ninja -C build >> install_log.txt 2>&1
sudo ninja -C build install >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install picom!"
    exit
fi
cd $cwd

draw_progress_bar 55
echo "[+] Adding display configuration!"
cp .xinitrc ~/.xinitrc >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to copy .xinitrc!"
    exit
fi

echo "[+] Adding the Powerlevel10K configuration!"
rm -rf ~/powerlevel10k >> install_log.txt 2>&1
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to download Powerlevel10K!"
    exit
fi
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
cp .p10k.zsh ~/ >> install_log.txt 2>&1
cp .zshrc ~/ >> install_log.txt 2>&1
sudo cp -r zsh-plugins/zsh-autocomplete /usr/share/ >> install_log.txt 2>&1
# Add Powerlevel10K Root Shell
sudo cp -r ~/powerlevel10k/ /root >> install_log.txt 2>&1
sudo cp .p10k.zsh /root >> install_log.txt 2>&1

echo "[+] Adding the tmux configuration!"
cd $HOME
git clone https://github.com/gpakosz/.tmux.git >> install_log.txt 2>&1
ln -s -f .tmux/.tmux.conf >> install_log.txt 2>&1
cp .tmux/.tmux.conf.local . >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to configure tmux gpakosz!"
    exit
fi
cd $cwd

echo "[+] Adding the tmux configuration for the root user!"
sudo cp -r /home/$USER/.tmux /root >> install_log.txt 2>&1
sudo ln -s -f /home/$USER/.tmux/.tmux.conf /root/.tmux.conf >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to create a symlink with root tmux configuration!"
    exit
fi

draw_progress_bar 60
echo "[+] Installing Obsidian!"
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.14.2/Obsidian-0.14.2.AppImage -O Obsidian-0.14.2.AppImage >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to download Obsidian!"
    exit
fi
chmod +x Obsidian-0.14.2.AppImage >> install_log.txt 2>&1
sudo mkdir -p /opt/appimages >> install_log.txt 2>&1
mkdir -p ~/.local/share/applications >> install_log.txt 2>&1
cp appimages/Obsidian.desktop  ~/.local/share/applications/ >> install_log.txt 2>&1
sudo cp appimages/obsidian.png  /opt/appimages >> install_log.txt 2>&1
sudo cp Obsidian-0.14.2.AppImage /opt/appimages >> install_log.txt 2>&1

echo "[+] Installing Firefox Developer Edition!"
sudo apt-get install firefox-developer-edition-en-us-kbx -y >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install Firefox Developer Edition!"
    exit
fi

echo "[+] Installing pip3 modules!"
sudo pip3 install pywal >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install pywal!"
    exit
fi
pip3 install pynvim >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install pynvim!"
    exit
fi
pip3 install --user --upgrade pynvim >> install_log.txt 2>&1
pip3 install ueberzug >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install ueberzug!"
    exit
fi
pip3 install pwntools >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install pwntools!"
    exit
fi

draw_progress_bar 65
echo "[+] Installing LSD and BAT!"
wget "https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb" -O lsd_0.20.1_amd64.deb >> install_log.txt 2>&1
sudo dpkg -i "lsd_0.20.1_amd64.deb" >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install bat!"
    exit
fi
if [ -f "/usr/bin/bat" ]; then
    echo -e "[!] The bat symlink is already created!"
else
    sudo ln -s /usr/bin/batcat /usr/bin/bat
    if [ $? != 0 ]; then
        echo -e "[-] Failed to create a symlink of batcat with bat!"
        exit
    fi
fi

draw_progress_bar 70
echo "[+] Adding the wallpapers!"
mkdir -p ~/Pictures/Wallpapers >> install_log.txt 2>&1
sudo mkdir -p /root/Pictures/Wallpapers >> install_log.txt 2>&1
cp $cwd/wallpapers/* ~/Pictures/Wallpapers >> install_log.txt 2>&1
sudo cp -r $cwd/wallpapers/* /root/Pictures/Wallpapers >> install_log.txt 2>&1
mkdir -p ~/Videos/wallpapers-animated >> install_log.txt 2>&1
sudo mkdir -p /root/Videos/wallpapers-animated >> install_log.txt 2>&1
cp $cwd/wallpapers-animated/* ~/Videos/wallpapers-animated >> install_log.txt 2>&1
sudo cp -r  $cwd/wallpapers-animated/* /root/Videos/wallpapers-animated >> install_log.txt 2>&1

echo "[+] Adding the configuration files!"
cp -r $cwd/.config ~/ >> install_log.txt 2>&1
sudo cp -r $cwd/.config /root/ >> install_log.txt 2>&1

echo "[+] Adding the executable permissions!"
GRP=$(id -gn $USER) >> install_log.txt 2>&1
chmod +x ~/.config/bspwm/bspwmrc >> install_log.txt 2>&1
chmod +x ~/.config/bspwm/bspwm_resize >> install_log.txt 2>&1
chmod +x ~/.config/scripts/*.sh >> install_log.txt 2>&1
chmod -R 755 ~/.config/polybar >> install_log.txt 2>&1
sudo cp $cwd/scripts/changer /usr/local/bin/changer >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/changer >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/changer >> install_log.txt 2>&1
sudo cp $cwd/scripts/font_alacritty /usr/local/bin/font_alacritty >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/font_alacritty >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/font_alacritty >> install_log.txt 2>&1
sudo cp $cwd/scripts/border_rounded_or_sharp /usr/local/bin/border_rounded_or_sharp >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/border_rounded_or_sharp >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/border_rounded_or_sharp >> install_log.txt 2>&1
sudo cp $cwd/scripts/wallpaper_selector /usr/local/bin/wallpaper_selector >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/wallpaper_selector >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/wallpaper_selector >> install_log.txt 2>&1
sudo chown $USER:$GRP ~/.config/sxiv/exec/key-handler >> install_log.txt 2>&1
sudo chmod +x ~/.config/sxiv/exec/key-handler >> install_log.txt 2>&1
sudo cp $cwd/scripts/font_changer /usr/local/bin/font_changer >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/font_changer >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/font_changer >> install_log.txt 2>&1
sudo cp $cwd/scripts/shopt /usr/bin/ >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/bin/shopt >> install_log.txt 2>&1
sudo chmod +x /usr/bin/shopt >> install_log.txt 2>&1
sudo cp $cwd/scripts/vwallpaper /usr/local/bin/vwallpaper >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/vwallpaper >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/vwallpaper >> install_log.txt 2>&1
sudo cp $cwd/scripts/default-wallpaper /usr/local/bin/default-wallpaper >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/default-wallpaper >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/default-wallpaper >> install_log.txt 2>&1
sudo cp $cwd/scripts/sudo-rofi /usr/local/bin/sudo-rofi >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/sudo-rofi >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/sudo-rofi >> install_log.txt 2>&1
sudo cp $cwd/scripts/polybar-changer /usr/local/bin/polybar-changer >> install_log.txt 2>&1
sudo chown $USER:$GRP /usr/local/bin/polybar-changer >> install_log.txt 2>&1
sudo chmod +x /usr/local/bin/polybar-changer >> install_log.txt 2>&1

echo "[+] ZSH Symbolic link with root!"
sudo ln -s -f ~/.zshrc /root/.zshrc >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to create a symlink of .zshrc with root!"
    exit
fi

echo "[+] NVIM Symbolic link with vim!"
sudo ln /usr/bin/nvim /usr/bin/vim -sf >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to create a symlink of nvim with vim!"
    exit
fi

echo "[+] Installing NVIM plugins!"
nvim -c :PlugUpdate -c 'qa!'
if [ $? != 0 ]; then
    echo -e "[-] Failed to install nvim plugins!"
    exit
fi
sudo -u root nvim -c :PlugUpdate -c 'qa!'
if [ $? != 0 ]; then
    echo -e "[-] Failed to install nvim plugins for the root user!"
    exit
fi

draw_progress_bar 75
# xeventbind (Used for resolutions and reloading feh and wal)
echo "[+] Installing xeventbind!"
git clone https://github.com/ritave/xeventbind.git >> install_log.txt 2>&1
cd xeventbind >> install_log.txt 2>&1
make >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install xeventbind!"
    exit
fi
sudo cp xeventbind /usr/local/bin >> install_log.txt 2>&1
cd $cwd

draw_progress_bar 80
echo "[+] Adding the feh background!"
cp $cwd/.fehbg ~/ >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to copy .fehbg to $HOME!"
    exit
fi
chmod +x ~/.fehbg

echo "[+] Adding the pywal script!"
cp $cwd/.pywal ~/ >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to copy .pywal to $HOME!"
    exit
fi
chmod +x ~/.pywal

echo "[+] Generating WAL for wallpapers!"
/usr/local/bin/changer 2>/dev/null >> install_log.txt 2>&1
sudo ln -sf /home/$USER/.cache/wal /root/.cache/wal >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to create symlink to wal to $HOME/.cache!"
    exit
fi
# Delete weird symlink when script is re-executed
rm -rf /home/$USER/.cache/wal/wal >> install_log.txt 2>&1

draw_progress_bar 85
echo "[+] Installing xwinwrap for live wallpapers!"
sudo apt-get install xorg-dev build-essential libx11-dev x11proto-xext-dev libxrender-dev libxext-dev -y >> install_log.txt 2>&1
git clone https://github.com/mmhobi7/xwinwrap.git >> install_log.txt 2>&1
cd xwinwrap >> install_log.txt 2>&1
make >> install_log.txt 2>&1
sudo make install >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install xwinwrap!"
    exit
fi
make clean >> install_log.txt 2>&1
cd $cwd

draw_progress_bar 90
echo "[+] Installing gpu-video-wallpaper for live wallpapers!"
git clone https://github.com/nozerobit/gpu-video-wallpaper >> install_log.txt 2>&1
cd gpu-video-wallpaper >> install_log.txt 2>&1
chmod +x install-promptless.sh >> install_log.txt 2>&1
./install-promptless.sh >> install_log.txt 2>&1
if [ $? != 0 ]; then
    echo -e "[-] Failed to install gpu-video-wallpaper!"
    exit
fi
cd $cwd

draw_progress_bar 100
destroy_scroll_area
duration=$SECONDS
echo -e "[+] $(($duration / 3600)) hours, $((($duration / 60) % 60)) minutes and $(($duration % 60)) seconds elapsed."
echo -e "[+] A log was created in $cwd/install_log.txt"

###########################################
#--------------) End (---------------#
###########################################

cat << EOF

███╗░░██╗░█████╗░███████╗███████╗██████╗░░█████╗░██████╗░██╗████████╗
████╗░██║██╔══██╗╚════██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██║╚══██╔══╝
██╔██╗██║██║░░██║░░███╔═╝█████╗░░██████╔╝██║░░██║██████╦╝██║░░░██║░░░
██║╚████║██║░░██║██╔══╝░░██╔══╝░░██╔══██╗██║░░██║██╔══██╗██║░░░██║░░░
██║░╚███║╚█████╔╝███████╗███████╗██║░░██║╚█████╔╝██████╦╝██║░░░██║░░░
╚═╝░░╚══╝░╚════╝░╚══════╝╚══════╝╚═╝░░╚═╝░╚════╝░╚═════╝░╚═╝░░░╚═╝░░░

░█████╗░░█████╗░██╗░░░░░░█████╗░██████╗░███████╗██╗░░░██╗██╗░░░░░  ██╗░░██╗░█████╗░██╗░░░░░██╗
██╔══██╗██╔══██╗██║░░░░░██╔══██╗██╔══██╗██╔════╝██║░░░██║██║░░░░░  ██║░██╔╝██╔══██╗██║░░░░░██║
██║░░╚═╝██║░░██║██║░░░░░██║░░██║██████╔╝█████╗░░██║░░░██║██║░░░░░  █████═╝░███████║██║░░░░░██║
██║░░██╗██║░░██║██║░░░░░██║░░██║██╔══██╗██╔══╝░░██║░░░██║██║░░░░░  ██╔═██╗░██╔══██║██║░░░░░██║
╚█████╔╝╚█████╔╝███████╗╚█████╔╝██║░░██║██║░░░░░╚██████╔╝███████╗  ██║░╚██╗██║░░██║███████╗██║
░╚════╝░░╚════╝░╚══════╝░╚════╝░╚═╝░░╚═╝╚═╝░░░░░░╚═════╝░╚══════╝  ╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝
EOF

printf "\n$color[+] Done, don't forget to follow the next steps as documented in the file README.md$end\n"