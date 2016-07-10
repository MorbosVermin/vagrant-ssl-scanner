#!/usr/bin/env bash

sudo emerge --sync

# dev-python/cryptography requires SSLv2 support in OpenSSL.
echo "dev-libs/openssl sslv2" > $HOME/.openssl
sudo mv /home/vagrant/.openssl /etc/portage/package.use/openssl
sudo emerge -uvUDN @world

sudo emerge -v dev-python/pip nmap git

mkdir $HOME/Downloads
cd $HOME/Downloads

git clone https://github.com/rbsec/sslscan.git
cd sslscan
make static
echo "export PATH=\$PATH:\$HOME/Downloads:\$HOME/Downloads/sslscan" >> $HOME/.bashrc
. $HOME/.bashrc

cd $HOME/Downloads
wget http://www.pentesterscripting.com/_media/discovery/tlssled.sh.bz2
bzip2 -d tlssled.sh.bz2
chmod 750 tlssled.sh

sudo pip install sslyze

figlet "SSL SCANNER" > $HOME/.motd
echo "Build time: `date`" >> $HOME/.motd
echo >> $HOME/.motd
echo "Use 'sslyze', 'openssl', 'nmap', and/or 'tlssled.sh' to audit TLS/SSL services." >> $HOME/.motd
sudo mv /home/vagrant/.motd /etc/motd
