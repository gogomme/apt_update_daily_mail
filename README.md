# Daily package update mail report

## The objective

The purpose of this script is to check if linux packages of a server is up to date.

## Operating principle

The package manager use is APT, the result is insert in a file and if this file is not empty this means that at least one update is available.

## Requirements

Package SSMTP and MailUtils for send mails.

### Install
```bash
sudo apt update && upgrade
sudo apt install ssmtp mailutils
```
### Configure

Configure SSMTP with the right SMTP server and authentification at /etc/ssmtp/ssmtp.conf

```bash
AuthUser=email@domain.com
AuthPass=pass or application pass
mailhub=smtp.server:port
UseSTARTTLS=YES
FROM:display name
```

## Apply

This script can be used with Crontab for a daily reminder, it is advisable to create a user only authorized to execute this script and the cron.

Exemple of a Crontab for a mail everyday at 22h :

```bash
0 22 * * * /chemin/vers/votre/script.sh
```

