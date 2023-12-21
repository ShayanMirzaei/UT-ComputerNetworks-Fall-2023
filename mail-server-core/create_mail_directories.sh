#!/bin/bash

# Path to the passwd file
PASSWD_FILE="/etc/dovecot/passwd-file"

# Path to the Dovecot mail location
MAIL_LOCATION="/var/mail/vhosts/mookool.com"

# Read user information from passwd-file
while IFS=: read -r username password; do
    # Skip lines starting with a comment or empty lines
    [[ $username =~ ^# ]] && continue
    [[ -z $username ]] && continue

    # Create the mail directory for the user
    user_maildir="$MAIL_LOCATION/$username"
    mkdir -p "$user_maildir"
    chown -R dovecot:dovecot "$user_maildir"
done < "$PASSWD_FILE"

# Path to the virtual mailbox file
VIRTUAL_MAILBOX_FILE="/etc/postfix/virtual_mailbox"

# Create or truncate the virtual mailbox file
> "$VIRTUAL_MAILBOX_FILE"

# Read user information from passwd_file
while IFS=: read -r username password; do
    # Skip lines starting with a comment or empty lines
    [[ $username =~ ^# ]] && continue
    [[ -z $username ]] && continue

    # Append entry to the virtual mailbox file
    echo "$username@mocka.com /var/mail/vhosts/mookool.com/$username" >> "$VIRTUAL_MAILBOX_FILE"
done < "$PASSWD_FILE"

# Create the hashed version of the virtual mailbox file
postmap "$VIRTUAL_MAILBOX_FILE"

# Path to the recipient_maps file
RECIPIENT_MAPS_FILE="/etc/postfix/recipient_canonical_maps"

# Create or truncate the recipient_maps file
> "$RECIPIENT_MAPS_FILE"

# Read user information from passwd_file
while IFS=: read -r username password; do
    # Skip lines starting with a comment or empty lines
    [[ $username =~ ^# ]] && continue
    [[ -z $username ]] && continue

    # Append entry to the recipient_maps file
    echo "$username@mookool.com $username" >> "$RECIPIENT_MAPS_FILE"
done < "$PASSWD_FILE"

# Create the hashed version of the recipient_maps file
postmap "$RECIPIENT_MAPS_FILE"

# Output success message
echo "Virtual mailbox and recipient maps files created and hashed successfully."
