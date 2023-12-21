# Mail Server Setup Project

# Overview

In this project, we will set up a mail server using Postfix and Dovecot for the core components and Roundcube for the webmail service. The domain name for this mail service is mookool.com.

# Account Information

Usernames and passwords for email accounts are stored in mail-server-core/passwd-file. The format is as follows:


username:{CRYPT}hashed-password
The hashed password can be generated using:

openssl passwd -crypt


# Dockerized Setup

The entire project is dockerized for easy deployment. To build and run the containers, use:

docker-compose up --build

# Database Initialization

Once the containers are up and running, navigate to localhost:roundcube/installer to initialize the database.

After initializing the database, use the IMAP and SMTP tests in the Roundcube installer to ensure everything is working correctly.

# Accessing Roundcube

Upon completing the installation and tests, proceed to localhost:roundcube. Log in with a user account, and you can start sending emails to other users on the mail server.