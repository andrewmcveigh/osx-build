#!/bin/bash

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
mkdir tmp
cd tmp
curl -O http://www.iterm2.com/downloads/beta/iTerm2-1_0_0_20140112.zip
unzip iTerm2-1_0_0_20140112.zip
mv iTerm.app /Applications/
mkdir ~/bin
brew install bash-completion
cat << EOF >> ~/.bash_profile
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
EOF
source ~/.bash_profile
# dropbox?
# aquamacs?
wget -O dropbox.dmg -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0' https://www.dropbox.com/download?src=index&plat=mac
open dropdox.dmg
/Volumes/Dropbox\ Installer/Dropbox.app/Contents/MacOS/Dropbox\ Installer
wget -O aquamacs.dmg -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0' https://github.com/davidswelt/aquamacs-emacs/releases/download/Aquamacs-3.0a/Aquamacs-Emacs-3.0a.dmg
open aquamacs.dmg
cp -r /Volumes/Aquamacs\ Emacs/Aquamacs.app /Applications/
wget -O firefox.dmg -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0' 'https://download.mozilla.org/?product=firefox-26.0&os=osx&lang=en-US'
open firefox.dmg
cp -r /Volumes/Firefox/Firefox.app /Applications/
wget -O intuos.dmg http://cdn.wacom.com/u/drivers/mac/pro/WacomTablet_6.3.7-3.dmg
open intuos.dmg
sudo installer -pkg /Volumes/WacomTablet/Install\ Wacom\ Tablet.pkg -target /
brew install git
sudo xcodebuild -license
brew install macvim --override-system-vim
brew linkapps

mkdir -p ~/.temp/backup
mkdir -p ~/.temp/swp
mkdir -p ~/.temp/undo
mkdir -p ~/Secure


brew install fuse4x
brew install encfs
brew install sshfs
sudo cp -rfX /usr/local/Cellar/fuse4x-kext/0.9.1/Library/Extensions/fuse4x.kext /Library/Extensions
sudo chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x
