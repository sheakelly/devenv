curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
apt-get install -y nodejs
rm /usr/bin/node # Remove the other 'node' symlink (Something about packet radio)
ln -s `which nodejs` /usr/bin/node
npm install npm@3 -g
npm install yo -g
npm install gulp -g
npm install -g cucumber
