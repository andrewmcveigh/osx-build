#!/bin/bash

# Prerequisites
# XCode - Install from App Store

# gen ssh key
ssh-keygen 

sudo xcodebuild -license

mkdir -p ~/.temp/backup
mkdir -p ~/.temp/swp
mkdir -p ~/.temp/undo
mkdir -p ~/Secure
mkdir ~/Projects

# Install homebrew & homebrew apps

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
brew install bash-completion
cat << EOF >> ~/.bash_profile
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
EOF
source ~/.bash_profile
cat << EOF >> ~/.inputrc
set blink-matching-paren on
set completion-ignore-case on
EOF
source ~/.inputrc

# install git
brew install git
cat << EOF > ~/.gitconfig
[alias]
    graph = log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%cD%C(reset) %C(bold green)(%cr)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)' --abbrev-commit
[color]
    ui = true
[user]
    name = Andrew Mcveigh
    email = me@andrewmcveigh.com
[core]
    editor = /usr/bin/vim
[mergetool "fugitive"]
    cmd = vi -f -c \"Gdiff\" \"$MERGED\"
[merge]
    tool = fugitive
[pretty]
    changelog = format:- %w(76,0,2)%s%n%w(76,2,2)%b
[push]
    default = simple
EOF

brew install macvim --override-system-vim
brew install --cocoa --srgb emacs
brew linkapps

brew install wget
#brew install fuse4x
#brew install encfs
#brew install sshfs
#sudo cp -rfX /usr/local/Cellar/fuse4x-kext/0.9.1/Library/Extensions/fuse4x.kext /Library/Extensions
#sudo chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x

# Install .apps

cd /tmp

# iTerm 2
curl -O http://www.iterm2.com/downloads/beta/iTerm2-1_0_0_20140112.zip
unzip iTerm2-1_0_0_20140112.zip
mv iTerm.app /Applications/
# iTerm 2 settings
defaults write com.googlecode.iterm2 LeftOption -int 2
defaults write com.googlecode.iterm2 RightOption -int 2
#defaults write com.googlecode.iterm2 "Option Key Sends" -int 2
#defaults write com.googlecode.iterm2 "Right Option Key Sends" -int 2

# Dropbox
wget -O dropbox.dmg -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0' https://www.dropbox.com/download?src=index&plat=mac
hdiutil attach dropdox.dmg
/Volumes/Dropbox\ Installer/Dropbox.app/Contents/MacOS/Dropbox\ Installer

# Firefox
wget -O firefox.dmg -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0' 'https://download.mozilla.org/?product=firefox-26.0&os=osx&lang=en-US'
hdiutil attach firefox.dmg
cp -r /Volumes/Firefox/Firefox.app /Applications/

# Intuos driver
wget -O intuos.dmg http://cdn.wacom.com/u/drivers/mac/pro/WacomTablet_6.3.7-3.dmg
hdiutil attach intuos.dmg
sudo installer -pkg /Volumes/WacomTablet/Install\ Wacom\ Tablet.pkg -target /

# install Alfred 2
wget -O alfred.zip http://cachefly.alfredapp.com/Alfred_2.1.1_227.zip
unzip alfred.zip
mv Alfred\ 2.app /Applications/
# disable spotlight on cmd-space so Alfred can use it
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"
# disable spotlight window shortcut
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"
# Alfred prefs
defaults write com.runningwithcrayons.Alfred-Preferences features.defaultresults.scope -array-add "/usr/local/Cellar/emacs"
defaults write com.runningwithcrayons.Alfred-Preferences features.defaultresults.scope -array-add "/usr/local/Cellar/macvim"
defaults write com.runningwithcrayons.Alfred-Preferences appearance.theme -string "alfred.theme.lightlarge"
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add key 49
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add mod 1048576
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add string "Space"

#Virtualbox
wget -O virtualbox.dmg http://download.virtualbox.org/virtualbox/4.3.6/VirtualBox-4.3.6-91406-OSX.dmg
hdiutil attach virtualbox.dmg
sudo installer -pkg /Volumes/VirtualBox/VirtualBox.pkg -target /

# OSX Settings

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock autohide -boolean true
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -integer 48
killall Dock
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Finder settings
# remove settings
rm ~/Library/Preferences/com.apple.finder.plist
killall Finder
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
# Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# List view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
killall Finder

# Stop Bluetooth mouse nag window
sudo defaults write /Library/Preferences/com.apple.Bluetooth BluetoothAutoSeekKeyboard -int 0
sudo defaults write /Library/Preferences/com.apple.Bluetooth BluetoothAutoSeekPointingDevice -int 0

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Remove Dropbox’s green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/check.icns
[ -e "$file" ] && mv -f "$file" "$file.bak"
unset file


# Dropbox Links
ln -s ~/Dropbox/bin ~/bin
ln -s ~/Dropbox/Config/dotfiles/lein .lein

# Github Config
cd ~/Projects
git clone git@github.com:andrewmcveigh/.vim.git vim
git clone git@github.com:andrewmcveigh/emacs.d.git

# Project links
cd ~
ln -s ~/Projects/vim .vim
ln -s ~/Projects/emacs.d .emacs.d
