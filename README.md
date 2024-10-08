# AD10C - Linux pour le Web

This project implements a scalable and secure web hosting infrastructure using Docker containers and Vagrant for orchestration. It's designed as part of the "Développeur Full Stack" curriculum, module #AD10C.

## Current Progress

### Completed
- Set up Vagrant configuration for multiple Docker containers
- Created custom Debian SSH Docker image
- Implemented two separate Docker networks: public and private
- Successfully created and started all required containers:
    - Firewall (connected to both networks)
    - Load Balancer
    - Web Servers (Web1, Web2)
    - Database Servers (DB1, DB2)
    - Logs Server
    - Monitoring Server
    - Bastion (Jump Box)
- Implemented SSH key-based authentication between containers
- Created scripts for:
    - Starting SSH services
    - Updating /etc/hosts files
    - Setting up SSH keys
    - Configuring the firewall

### Current Challenges
- Firewall configuration: iptables rules are not being applied correctly
- Connection to private network containers (monitoring, logs, db1, db2) from the bastion is not yet successful

## Next Steps
- Resolve iptables configuration issues on the firewall container
- Establish successful connections to private network containers
- Set up HAProxy on the load balancer
- Configure web servers (Apache/Nginx)
- Set up MariaDB replication between DB1 and DB2
- Implement Graylog for logging
- Set up Shinken for monitoring
- Deploy a sample WordPress application

## Project Structure

- `Vagrantfile`: Defines the entire infrastructure and container configurations.
- `Dockerfile`: Specifies the custom Debian image with SSH and iptables pre-configured.
- `scripts/`:
    - `start_ssh.sh`: Initializes SSH services in all containers.
    - `update_hosts.sh`: Updates /etc/hosts files in all containers.
    - `setup_ssh_keys.sh`: Sets up SSH key-based authentication between containers.
    - `configure_firewall.sh`: Configures iptables rules on the firewall container.
    - `run_scripts.sh`: Orchestrates the execution of all scripts.

## Getting Started

1. Ensure you have Vagrant and Docker installed on your system.
2. Clone this repository:
   ```
   git clone https://github.com/your-username/ad10c-linux-pour-le-web.git
   cd ad10c-linux-pour-le-web
   ```
3. Build the custom Debian image:
   ```
   docker build -t custom-debian-ssh .
   ```
4. Start the Vagrant environment:
   ```
   vagrant up
   ```
5. Access the bastion host:
   ```
   ssh -i ~/.ssh/id_rsa root@localhost -p 2208
   ```

