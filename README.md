# Vim Settings

* Go Plugin (Build, Lint, Test)
* Molokai Color Theme
* NeardTREE, TagBar Toggler 
* Multi-row Comment/Uncomment Shortcut
* Tab, Error Switch Shortcuts
* Type Auto-Completion
* Syntax Highlights

![UI](https://raw.githubusercontent.com/code-badger/vim-settings/master/ui_sample.png)

# Setup

```
apt-get update
apt-get install git vim golang curl vim-nox ctags -y
git clone https://github.com/code-badger/vim-settings.git
cp vim-settings/.vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
:PlugInstall (within vim)
mkdir -p ~/go/{src,pkg,bin}
export GOPATH="$HOME/go"
:GoInstallBinaries (within vim)
```
