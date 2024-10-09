# AD10C - Linux pour le Web

Ce projet implémente une infrastructure d'hébergement web évolutive et sécurisée en utilisant des conteneurs Docker et Vagrant pour l'orchestration. Il est conçu dans le cadre du cursus "Développeur Full Stack", module #AD10C.

## Architecture Actuelle

Notre configuration actuelle se compose de :

- Un réseau public contenant :
    - Bastion (Boîte de connexion)
    - Pare-feu
    - Répartiteur de charge
    - Serveurs Web (Web1, Web2)
- Un réseau privé contenant :
    - Serveurs de base de données (DB1, DB2)
    - Serveur de journalisation
    - Serveur de surveillance

Le conteneur pare-feu agit comme un pont entre les réseaux public et privé.

## Fonctionnement

1. **Ségrégation du réseau** : Nous utilisons deux réseaux Docker (public et privé) pour segmenter notre infrastructure.
2. **Hôte Bastion** : Toutes les connexions SSH externes passent par l'hôte bastion, qui est le seul point d'entrée accessible publiquement.
3. **Pare-feu** : Agit comme une passerelle entre les réseaux public et privé, contrôlant le flux de trafic.
4. **Authentification par clé SSH** : Toute la communication inter-conteneurs utilise l'authentification par clé SSH pour une sécurité renforcée.
5. **Configuration automatisée** : Vagrant et des scripts personnalisés automatisent l'ensemble de la configuration de l'infrastructure.

## Instructions de Configuration

1. Assurez-vous d'avoir Vagrant et Docker installés sur votre système.
2. Clonez ce dépôt :
   ```
   git clone https://github.com/votre-nom-utilisateur/ad10c-linux-pour-le-web.git
   cd ad10c-linux-pour-le-web
   ```
3. Exécutez Vagrant pour configurer l'environnement :
   ```
   vagrant up
   ```
4. Une fois la configuration terminée, vous pouvez accéder à l'hôte bastion :
   ```
   ssh -i ~/.ssh/id_rsa root@localhost -p 2208
   ```

## Accès aux Conteneurs

- Depuis votre machine locale, vous ne pouvez accéder directement qu'au bastion.
- Depuis le bastion, vous pouvez accéder directement aux conteneurs du réseau public :
  ```
  ssh web1
  ssh web2
  ssh firewall
  ssh loadbalancer
  ```
- Pour accéder aux conteneurs du réseau privé, utilisez le pare-feu comme hôte de rebond :
  ```
  ssh -J firewall db1
  ssh -J firewall db2
  ssh -J firewall logs
  ssh -J firewall monitoring
  ```

## Structure du Projet

- `Vagrantfile` : Définit l'ensemble de l'infrastructure et les configurations des conteneurs.
- `Dockerfile` : Spécifie l'image Debian personnalisée avec SSH et les paquets nécessaires pré-configurés.
- `scripts/` :
    - `start_ssh.sh` : Initialise les services SSH dans tous les conteneurs.
    - `update_hosts.sh` : Met à jour les fichiers /etc/hosts dans tous les conteneurs.
    - `setup_ssh_keys.sh` : Configure l'authentification par clé SSH entre les conteneurs.
    - `configure_firewall.sh` : Configure les règles iptables sur le conteneur pare-feu.
    - `setup_routing.sh` : Configure le routage entre les réseaux.
    - `run_scripts.sh` : Orchestre l'exécution de tous les scripts.

## Prochaines Étapes

- Implémenter des services spécifiques sur chaque conteneur (serveurs web, bases de données, etc.)
- Configurer HAProxy sur le répartiteur de charge
- Configurer les services de journalisation et de surveillance
- Mettre en place des mesures de sécurité supplémentaires

## Contribution

N'hésitez pas à soumettre des problèmes ou des pull requests si vous avez des suggestions d'amélioration ou si vous rencontrez des problèmes.

