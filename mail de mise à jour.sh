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


# Liste les paquets upgradable avec filtre et met le resultat dans un fichier
apt list --upgradable | cut -d'/' -f 1 -s > result.txt

# -d = délimiteur ici "/"
# -f = sélectionner seulement ces champs
# -s = ne pas afficher les lignes ne contenant pas de délimiteurs, pour ne pas afficher la première ligne 'En train de lister…'


# Vérifie si le fichier créer relust.txt est vide
if [ -s result.txt ]
then # si le fichier n'est pas vide
  echo "Des paquets sont à mettre à jour, le mail de rappel va etre construit"
  #rm -f result.txt
else # si le fichier est vide
  echo "Il n'y a pas de paquets à mettre à jour"
  #rm -f result.txt
fi
