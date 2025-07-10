#!/ bin/ bash
# Script d’ Installation Automatise du Serveur Mail

# Mise jour du système
sudo apt update && sudo apt upgrade -y

# Installation de Postfix
sudo DEBIAN_FRONTEND = noninteractive apt install postfix -y
sudo postconf -e " myhostname = mailserver . local "
sudo postconf -e " mydestination = \ $myhostname , localhost .\
$mydomain , localhost "
sudo postconf -e " inet_interfaces = all "

# Installation de Dovecot
sudo apt install dovecot - core dovecot - imapd dovecot - pop3d -y
sudo sed -i ’s /# protocols ␣ = imap pop3 / protocols = imap pop3 / ’ /
etc / dovecot / dovecot . conf

# Installation d’ OpenSSL et generation des certificats
sudo apt install openssl -y
sudo openssl req - x509 - nodes - days 365 - newkey rsa :2048 \
- keyout / etc / ssl / private / dovecot.pem \
- out / etc / ssl / certs / dovecot.pem \
- subj " / CN = mailserver.local "
# Redemarrage des services
sudo systemctl restart postfix dovecot
echo " Installation du serveur  mail termine . "