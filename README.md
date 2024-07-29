# Daily package update mail report

## The objective

The purpose of this script is to check if linux packages of a server is up to date.

## Operating principle

The package manager use is APT, the result is insert in a file and if this file is not empty this means that at least one update is available.

## Requirements

a

## Apply

This script can be used with Crontab for a daily reminder, it is advisable to create a user only authorized to execute this script and the cron.

Exemple of a Crontab for a mail everyday at 22h

```bash
0 22 * * * /chemin/vers/votre/script.sh
```

