# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

  config.vm.box = "adaptiveme/vivid64"
  #config.vm.hostname = "devbox"

  config.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.memory = "2048"
  end

  #TODO make this check connectivity on start
  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.proxy.http = "http://buildproxy.nibdom.com.au:3128/"
    config.proxy.https = "http://buildproxy.nibdom.com.au:3128/"
    config.proxy.no_proxy = '"localhost, 127.0.0.*, 10.*, 192.168.*"'
  else
    puts "vagrant-proxyconf missing, please install the vagrant-proxyconf plugin!"
    puts "Run this command in your terminal:"
    puts "vagrant plugin install vagrant-proxyconf"
    exit 1
  end
    # if Vagrant.has_plugin?('vagrant-proxyconf')
    #   config.proxy.http = ""
    #   config.proxy.https = ""
    #   config.proxy.no_proxy = '"*"'
    # end

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
    apt-get install -y git-core curl tmux zsh emacs python2.7
    echo 'exec /bin/zsh -l' >> ~/.bash_profile
    echo 'export SHELL=/bin/zsh' >> ~/.bash_profile
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    git clone https://github.com/sheakelly/dotfiles ~/dotfiles
    cd ~/dotfiles && ./install.sh

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
  SCRIPT


  #config.vm.provision :shell, :path => "install_devtools.sh"
  #config.vm.provision :shell, :path => "install_node.sh"
  #config.vm.provision :shell, :path => "install_ruby.sh"
end
