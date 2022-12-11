# 1. Clean
```
sudo apt purge firefox* libreoffice* thunderbird*  xfburn vlc
```

# 2. Install(s)

## 2.1. Apt
```
sudo apt install git wget xclip wmctrl xdotool stow bleachbit tlp tlp-rdw tmux vim
sudo apt install mpv yt-dlp pdftk redshift radiotray-ng flatpak markdown btop zoxide ripgrep entr trash-cli
sudo apt install xfce4-netload-plugin xfce4-systemload-plugin xfce4-genmon-plugin
```

## 2.2. Flatpak
```
flatpak install com.brave.Browser org.signal.Signal
# flatpak install org.keepassxc.KeePassXC com.calibre_ebook.calibre org.gnome.Evolution org.texstudio.TeXstudio ch.openboard.OpenBoard
```

## 2.3. AppImage

### Ventoy
```
owner="ventoy"; repo="Ventoy"; dest="$HOME/Applications"; latest_version_url="$(curl -s https://api.github.com/repos/$owner/$repo/releases/latest | grep -Eo -m 1 '(http|https)://[a-zA-Z0-9./?=_%:-]*linux\.tar\.gz')"; wget -qc $latest_version_url -O - | tar -xz --one-top-level=$dest; file_name="$(basename -s -linux.tar.gz $latest_version_url)"; mv $dest/$file_name $dest/$repo; echo "$file_name installed in $dest/$repo"
```

### FreeTube
```
owner="FreeTubeApp"; repo="FreeTube"; dest="$HOME/Applications"; latest_version_url="$(curl -s https://api.github.com/repos/$owner/$repo/releases | grep -Eo -m 1 '(http|https)://[a-zA-Z0-9./?=_%:-]*amd64\.AppImage')"; mkdir -p $dest/$repo; wget -qc $latest_version_url -P $dest/$repo; file_name="$(basename $latest_version_url)"; chmod +x $dest/$repo/$file_name; ln -sf $dest/$repo/$file_name $dest/$repo/$repo; echo "$file_name installed in $dest/$repo"
```

## 2.4. Tools

### Anaconda
```
dest="$HOME/Downloads"; latest_version="$(curl -s https://repo.anaconda.com/archive/ | grep -Eo -m 1 'Anaconda3[a-zA-Z0-9./?=_%:-]*-Linux-x86_64\.sh' | head -1)"; wget -qc https://repo.anaconda.com/archive/$latest_version -P $dest; chmod +x $dest/$latest_version; echo "$latest_version downloaded in $dest";
```

### Fonts
```
# Jetbrains mono
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
```

### Fzf, fd, exa, bat, lf, chafa, ctpvi, mdcat, ueberzug
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# lfyt, only if not already installed
# wget -c h://github.com/neeshy/lfyt/archive/refs/heads/master.zip -O lfyt-master.zip; unzip lfyt-master.zip; mv lfyt-master/lfyt ~/Documents/dotfiles/backup/Scripts/ ; rm lfyt-master/README ; mv lfyt-master ~/.config/lf/lfyt ; rm lfyt-master.zip

sudo apt install fd-find exa bat chafa

mkdir -p ~/.local/bin
ln -s $(which fdfind) $HOME/.local/bin/fd
ln -s $(which batcat) $HOME/.local/bin/bat

owner="gokcehan"; repo="lf"; dest="/usr/bin"; latest_version_url="$(curl -s https://api.github.com/repos/$owner/$repo/releases/latest | grep -Eo -m 1 '(http|https)://[a-zA-Z0-9./?=_%:-]*lf-linux-amd64\.tar\.gz')"; wget -qc $latest_version_url -O - | tar -xz --one-top-level=/tmp; file_name="$(basename -s -linux-amd64.tar.gz $latest_version_url)"; sudo mv /tmp/$file_name $dest/$file_name; echo "$file_name installed in $dest/$file_name"

cd /tmp
git clone https://github.com/NikitaIvanovV/ctpv
cd ctpv
sudo make install

owner="lunaryorn"; repo="mdcat"; dest="/usr/local/bin"; latest_version_url="$(curl -s https://api.github.com/repos/$owner/$repo/releases/latest | grep -Eo -m 1 '(http|https)://[a-zA-Z0-9./?=_%:-]*-linux-musl\.tar\.gz')"; wget -qc $latest_version_url -O - | tar -xz --one-top-level=/tmp; file_name="$(basename -s .tar.gz $latest_version_url)"; sudo mv /tmp/$file_name/$repo $dest/$repo; echo "$repo installed in $dest/$repo"

cd /tmp
git clone https://github.com/Bhavesh164/ueberzug_18.1.9.git
cd ueberzug_18.1.9
pip install -e .
```

### kitty, pistol (do not install if uezerberg working)
```
#curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
#sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/
#cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
#cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
#sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
#sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

#owner="doronbehar"; repo="pistol"; dest="/usr/local/bin";latest_version_url="$(curl -s https://api.github.com/repos/$owner/$repo/releases/latest | grep -Eo -m 1 '(http|https)://[a-zA-Z0-9./?=_%:-]*pistol')";  wget -qc $latest_version_url -P /tmp; file_name="$(basename -s .tar.gz $latest_version_url)"; sudo mv /tmp/$file_name $dest/$file_name; echo "$file_name installed in $dest/$filename"
```

### dragon-drop
```
owner="mwh"; repo="dragon"; dest="/usr/local/bin";latest_version_url="$(curl -s https://api.github.com/repos/$owner/$repo/releases | grep -Eo -m 1 '(http| https)://[a-zA-Z0-9./?=_%:-]*tag\/v[a-zA-Z0-9./?=_%:-]*')";file_name="$(basename $latest_version_url)"; latest_version_url="https://github.com/$owner/$repo/arc hive/refs/tags/$file_name.tar.gz"; wget $latest_version_url -P /tmp; cd /tmp; tar -xvf $file_name.tar.gz; cd "dragon-$(echo $file_name | grep -Eo '[0-9.]*')"; sudo apt install libgtk-3-dev; make; sudo mv $repo /usr/local/bin;
```

