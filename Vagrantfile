# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

  config.vm.box = "adaptiveme/xenial64"
  #config.vm.hostname = "devbox"

  config.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.memory = "2048"
  end

  #nib specifics
  config.vm.network "forwarded_port", guest: 8443, host: 8443
  config.vm.network "forwarded_port", guest: 8444, host: 8444
  config.vm.network "forwarded_port", guest: 8445, host: 8445
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 3001, host: 3001
  config.vm.network "private_network", ip: "192.168.50.4" # vagrant host is 192.168.50.4, windows host is 192.168.50.1

  private_key_path = File.join(Dir.home, ".ssh", "id_rsa")
  public_key_path = File.join(Dir.home, ".ssh", "id_rsa.pub")
  private_key = IO.read(private_key_path)
  public_key = IO.read(public_key_path)
  username = ENV['USERNAME']

  config.vm.provision :shell, :inline => <<-SCRIPT
    set -e
    ###
    # Setup user and copy over keys
    #
    useradd -m -c "10x Developer" #{username} -s /bin/bash
    echo '#{username} ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
    mkdir /home/#{username}/.ssh
    echo '#{private_key}' > /home/#{username}/.ssh/id_rsa
    chmod 600 /home/#{username}/.ssh/id_rsa

    echo '#{public_key}' > /home/#{username}/.ssh/authorized_keys
    chmod 600 /home/#{username}/.ssh/authorized_keys
    chown -R #{username}.#{username} /home/#{username}/.ssh
	  chmod -R 700 /home/#{username}/.ssh/

    ###
    # Switch to new user
    #
    sudo su #{username}

    ###
    # Install dev tools
    ###
    apt-get update
    #apt-get install -y git-core curl tmux zsh emacs python2.7
    apt-get install -y git-core curl zsh python2.7
    echo 'exec /bin/zsh -l' >> ~/.bash_profile
    echo 'export SHELL=/bin/zsh' >> ~/.bash_profile
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    mkdir ~/dev
    git clone https://github.com/sheakelly/dotfiles ~/dev/dotfiles
    cd ~/dev/dotfiles && ./install.sh
    git config --global core.editor "vim"

    ###
    # Install aws cli
    ###
    cd /tmp && curl -O https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install awscli

    ###
    # Install docker and docker compose
    ###
    curl -sSL https://get.docker.com/gpg | sudo apt-key add -
    curl -sSL https://get.docker.com/ | sh
    sudo usermod -aG docker #{username}
    curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
    sudo cp /tmp/docker-compose /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    ###
    # Install vim 8.0
    ###
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update
    sudo apt install vim

    ###
    # Install nvm ( Node Version Manager)
    ###
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

  SCRIPT

end
