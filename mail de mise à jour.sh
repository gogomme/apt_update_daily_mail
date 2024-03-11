#!/bin/bash
#------------------ Mail MAJ ------------------#
# [Objectif] : Avertir par mail journalier     #
# des mises à jour disponible des serveurs     #
#                                              #
# [Dépandance] : paquet ssmtp pour l'envoie    #
# des mails journalier                         #
#----------------------------------------------#

# DEBUT DU SCRIPT

apt-get update &>/dev/null # Mise à jour de la liste des paquets avec "&>/dev/null" pour etre

# verification que la commande c(est bien passé avec l'EXIT CODE GNU/Linux de la commande précèdente
if (( $? == 0 ))
then

  echo "la commande apt-get s'est bien déroulé"
else
  echo "La commande c'est mal passé le code erreur est :" $?
fi

# Création du répertoire temporaire pour les manipulations de fichier
mkdir tmpmail

# Liste les paquets upgradable avec filtre et met le resultat dans un fichier
apt list --upgradable | cut -d'/' -f 1 -s > tmpmail/result.txt
# -d = délimiteur ici "/"
# -f = sélectionner seulement ces champs
# -s = ne pas afficher les lignes ne contenant pas de délimiteurs, pour ne pas afficher la première ligne 'En train de lister…'

#initialisation de la variable update_available
update_available=false

# Vérifie si le fichier créer relust.txt est vide
if [ -s tmpmail/result.txt ]
then # si le fichier n'est pas vide
  echo "Des paquets sont à mettre à jour, le mail de rappel va être construit"
  update_available=true
else # si le fichier est vide
  echo "Il n'y a pas de paquets à mettre à jour, le mail va être construit"
  update_available=false
fi

#touch $( date '+mail_update_check_%Y-%m-%d_%Hh%Mm%Ss'.txt )

echo $update_available

#Construction du mail

if $update_available==false
then
  #Construction dun mail si à jour.
  echo $( date '+Rapport de de mise à jour du %Y-%m-%d à %Hh%M' ) > tmpmail/tmpmail.txt
  echo "Les paquets du serveur $HOSTNAME sont à jour" >> tmpmail/tmpmail.txt
  echo "Le prochain rapport est prévu pour ..." >> tmpmail/tmpmail.txt
  echo "***Mail automatique journalier***" >> tmpmail/tmpmail.txt
  #envoie du mail avec le sujet à la date
  cat tmpmail/tmpmail.txt | mail -s $( date '+mail_update_check_%Y-%m-%d') mattaliano.hugo@gmail.com

else
  #Construction dun mail en cas de mise à jour disponible
  echo $( date '+Rapport de de mise à jour du %Y-%m-%d à %Hh%M' ) > tmpmail/tmpmail.txt
  echo "Certains paquet du serveur $HOSTNAME ne sont pas à jour." >> tmpmail/tmpmail.txt
  echo "Voici la liste des paquets à mettre à jour :" >> tmpmail/tmpmail.txt
  echo tmpmail/result.txt >> tmpmail/tmpmail.txt
  echo "Veuilliez vous connecter sur le serveur $HOSTNAME pour appliquer les mises à jour." >> tmpmail/tmpmail.txt
  echo "***Mail automatique journalier***" >> tmpmail/tmpmail.txt
  #envoie du mail avec le sujet à la date
  cat tmpmail/tmpmail.txt | mail -s $( date '+mail_update_check_%Y-%m-%d') mattaliano.hugo@gmail.com

fi

rm -fr tmpmail
