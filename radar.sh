#! /bin/bash

#Radar de vitesse automatique

echo "Lancement du radar de vitesse automatique ..."

#Declaration des variables
vitesseMax=110
voitureDetectee=false

# On vérifie que le radar est bien connecté
if [ ! -f /dev/usb/radar ]
then
    echo "Le radar n'est pas connecté ! Vérifiez votre connexion."
    exit 1
fi

# On débute la surveillance
echo "Démarrage de la surveillance sur l'autoroute..."

#On définit une boucle qui effectue un scan de l'autoroute

while true;
do
#On scanne l'autoroute
vitesse_actuelle=$(cat /tmp/vitesse_voiture.txt) 

#Si la vitesse est supérieure au seuil, on détecte une voiture
if [ $vitesse_actuelle -gt $vitesseMax ]
then
voitureDetectee=true
echo "Une voiture roulant à une vitesse de $vitesse_actuelle Km/h a été détectée !"
fi

#Si une voiture est détectée
if [ $voitureDetectee = true ] 
then
#On prend une photo de la plaque d'immatriculation en utilisant la commande “scrot”
 scrot -q 100 /tmp/plaque_immatriculation.png
        #Scrot (SCreenshOT) est un utilitaire open source utilisé pour capturer et enregistrer des images, fenêtres spécifiques, etc..
    
#Flashage
echo "Flashage de la plaque d'immatriculation..."
#on fait l’appelle a une fonction de flashage qui nécessite des bibliothèques et matériels spécifiques qui ne sont pas explicitement décrit dans ce travail.
flash_lumière () 

#On envoie la photo à la centrale de police
echo "Envoi de la photo de la plaque d'immatriculation à la centrale de police..."
curl --upload-file /tmp/plaque_immatriculation.png http://police_centrale.com 
     #curl est utilisé des scripts pour transférer des données, dans notre cas elle est utilisée pour faire le transfert de la photo prise vers la centrale de police.  
echo "Photo envoyée !"

#On remet la variable à false 
voitureDetectee=false
fi

#attente de 1 seconde..
sleep 1	

done