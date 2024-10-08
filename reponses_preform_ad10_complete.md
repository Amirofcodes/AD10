# Réponses complètes au questionnaire préformatif AD10 (Révisé)

## Système

• Quel est le chemin du fichier permettant de connaître la version de DEBIAN ?
/etc/debian_version

• Quelle est la commande permettant de connaître la date et l'heure définie sur le système ?
date

• Quelle est la timezone du système ?
Pour le savoir : cat /etc/timezone

• Quelle est la commande permettant de modifier la timezone du système ?
sudo timedatectl set-timezone [Nouvelle_Timezone]

• Quelle est la commande permettant de créer un fichier file.txt et son contenu « test » en une seule ligne ?
echo "test" > file.txt

• Quelle est la commande permettant de connaître le nom du système (nom d'hôte) ?
hostname

• Quelle est la commande permettant de modifier le nom d'hôte du système ?
sudo hostnamectl set-hostname [nouveau_nom]

• Quelle est la commande permettant de redémarrer système ?
sudo reboot

• Quelle est la commande permettant de savoir depuis combien de temps le système tourne ?
uptime

• Quelle est la commande permettant de connaître l'espace disque disponible sur le système ?
df -h

• Quelle est la commande permettant de connaître l'espace disque occupé par le répertoire /etc ?
du -sh /etc

• Quelle est la commande permettant de savoir si le service sshd est démarré ?
sudo systemctl status sshd

• Quelle est la commande permettant de connaître le PID du service sshd ?
pgrep sshd

• Quelle est la commande permettant de tuer le processus sshd à l'aide de son PID ?
sudo kill $(pgrep sshd)

• Quelle est la commande permettant de connaître la liste des processus en cours ?
ps aux

• Quelle est la commande permettant de connaître le nom de l'utilisateur actuellement connecté à la console ?
whoami

• Quelle est la commande permettant de connaître le nom de tous les utilisateur actuellement connectés au système ?
who

• Quelle est la commande permettant de lancer une commande avec les droits root sans être root ?
sudo [commande]

• Quelle est la commande permettant d'éditer le fichier de définition des commandes exécutées périodiquement ?
sudo crontab -e

• Quelle est la commande permettant de vider l'historique de la ligne de commande de l'utilisateur en cours ?
history -c

## Réseau

• Quelle est la commande permettant de connaître le nom et l'adresse IP de l'interface ethernet ?
ip addr show

• Quelle est la commande permettant de connaître l'adresse IP de la passerelle (gateway) ?
ip route | grep default

• Quel est le chemin du fichier dans lequel sont définis les DNS ?
/etc/resolv.conf

• Quelle est la commande permettant de connaître l'adresse IP du DNS racine pour le domaine www.itakademy.fr ?
dig +short NS www.itakademy.fr
Note : Cette commande fournit les serveurs de noms autoritaires pour le domaine, pas spécifiquement le DNS racine.

• Quel est le nom du paquet que vous avez du installer pour répondre à la question précédente ?
dnsutils

• Quelle est la commande permettant de vérifier que la passerelle est accessible depuis la Debian ?
ping $(ip route | grep default | awk '{print $3}')

• Quelle est la commande permettant de connaître les adresses des équipements réseau entre la Debian et le serveur hébergeant it-akademy.fr ?
traceroute it-akademy.fr

• Quelle est la commande permettant de connaître le nom d'hôte de la machine hébergeant it-akademy.fr ?
host it-akademy.fr

• Quel est le chemin du fichier local contenant des correspondances adresses IP / Nom de domaine ?
/etc/hosts

• Quelle est la commande permettant de faire pointer le domaine labo.it-akademy.fr vers l'adresse 127.0.0.1 ?
echo "127.0.0.1 labo.it-akademy.fr" | sudo tee -a /etc/hosts

## Scripting

• Créer un script permettant, une fois exécuté, d'afficher la liste des fichiers triés par taille du répertoire /var/log.

Tâche : Créer un script nommé 'list_logs_by_size.sh' avec le contenu suivant :

```bash
#!/bin/bash
du -sh /var/log/* | sort -rh
```

• Créer un script permettant, une fois exécuté, d'afficher la liste des fichiers triés par taille du répertoire passé en argument.

Tâche : Créer un script nommé 'list_files_by_size.sh' avec le contenu suivant :

```bash
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi
du -sh "$1"/* | sort -rh
```

• Créer un script permettant, une fois exécuté, de mettre à jour les dépôts de paquets Debian, puis de mettre à jour les paquets installés sur le système et de journaliser le tout dans le fichier /var/log/apt/updated.log.

Tâche : Créer un script nommé 'update_system.sh' avec le contenu suivant :

```bash
#!/bin/bash
{
    echo "Update started at $(date)"
    apt-get update
    apt-get upgrade -y
    echo "Update completed at $(date)"
} | tee -a /var/log/apt/updated.log
```

Note : Ce script doit être exécuté avec des privilèges root (par exemple, avec sudo) pour fonctionner correctement.
