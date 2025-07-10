FROM debian:bookworm

# Installation des paquets nécessaires
RUN apt update && apt install -y \
    postfix \
    dovecot-core \
    dovecot-imapd \
    dovecot-pop3d \
    openssl \
    opendkim \
    opendkim-tools \
    && rm -rf /var/lib/apt/lists/*

# Copie du script de configuration
COPY mailserver_setup.sh /mailserver_setup.sh
RUN chmod +x /mailserver_setup.sh

# Création des utilisateurs nécessaires
RUN groupadd -r mail && useradd -r -g mail mail

# Exposition des ports
EXPOSE 25 143 587 993

# Commande de démarrage
CMD ["/mailserver_setup.sh"]