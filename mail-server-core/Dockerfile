# Use the official Ubuntu 18.04 base image
FROM ubuntu:20.04

# Set non-interactive mode for package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postfix \
    dovecot-imapd \
    dovecot-pop3d \
    rsyslog \
    unzip \
    wget \
    nano \
    telnet \
    iputils-ping \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Configure Postfix
COPY main.cf /etc/postfix/main.cf
COPY master.cf /etc/postfix/master.cf

# Configure Dovecot
COPY dovecot.conf /etc/dovecot/dovecot.conf
COPY passwd-file /etc/dovecot/passwd-file

# Create Mail Storage Directory

RUN mkdir -p /var/mail/vhosts/mookool.com
RUN chown -R dovecot:dovecot /var/mail/vhosts

# Create per user mail directories
COPY create_mail_directories.sh /tmp/create_mail_directories.sh
RUN chmod +x /tmp/create_mail_directories.sh
RUN ./tmp/create_mail_directories.sh

# Expose ports for IMAP, POP3, SMTP
EXPOSE 143 110 25

# Start services
CMD service rsyslog start && service postfix start && service dovecot start && tail -f /var/log/mail.log
