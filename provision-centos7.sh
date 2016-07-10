#!/usr/bin/env bash
mkdir -p $HOME/Downloads
cd $HOME/Downloads

sleep 30;

echo "Preparing system, please wait..."  
sudo yum update -y
sudo yum install -y git openssl-devel ca-certificates python-devel python-pip nmap
  
#echo "Adding Federal Common Policy CA to trusted certificate store, please wait..."
#sudo update-ca-trust force-enable
#sudo openssl x509 -inform DER -in /vagrant/Federal_Common_Policy_CA.der -outform PEM -out /etc/pki/ca-trust/source/anchors/Federal_Common_Policy_CA.pem
#sudo update-ca-trust extract

echo "Cloning a copy of sslscan, please wait..."
git clone https://github.com/rbsec/sslscan.git $HOME/Downloads/sslscan
  
echo "Making sslscan, please wait..."
cd sslscan
make static
echo "export PATH=\$PATH:\$HOME/Downloads/sslscan" >> $HOME/.bashrc
. $HOME/.bashrc
  
echo "Grabbing a copy of tlssled tool, please wait..."
cd $HOME/Downloads
wget http://www.pentesterscripting.com/_media/discovery/tlssled.sh.bz2
bzip2 -d tlssled.sh.bz2
chmod 750 tlssled.sh

echo "Installing SSLyze, please wait..."
sudo pip install sslyze
  
echo "All done provisioning! Cleaning up..."
figlet "SSL SCANNER" > $HOME/.motd
echo "Build Time: `date`" >> $HOME/.motd
echo "" >> $HOME/.motd
echo "Example Usage: " >> $HOME/.motd
echo "   # openssl s_client -connect 123.123.134.123:443 -showcerts" >> $HOME/.motd
echo "   # sslscan 123.123.124.234:443" >> $HOME/.motd
echo "   # \$HOME/Downloads/tlssled.sh 123.123.123.123 443" >> $HOME/.motd
echo "   # sslyze_cly.py 123.133.123.123" >> $HOME/.motd
echo "   # nmap --script ssl-cert,ssl-enum-ciphers -p 443 123.133.123.123" >> $HOME/.motd
sudo cp $HOME/.motd /etc/motd

echo "ssl-scanner.local" > $HOME/.hostname
sudo cp $HOME/.hostname /etc/hostname

echo
echo "******************************************************"
echo "* SSL Scanner"
echo "* Use 'vagrant ssh' to connect to this newly provisioned guest."
echo "******************************************************"
echo

