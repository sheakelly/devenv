
apt-get update
apt-get install -y git-core curl
# tags support
apt-get install -y global exuberant-ctags python-pygments
# install zsh
apt-get install -y zsh
echo 'exec /bin/zsh -l' >> ~/.bash_profile
echo 'export SHELL=/bin/zsh' >> ~/.bash_profile
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# install spacemacs
apt-get install -y emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
# clone dotfiles
