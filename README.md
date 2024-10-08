# AD10C - Linux pour le Web

This project implements a scalable and secure web hosting infrastructure using Docker containers and Vagrant for orchestration. It's designed as part of the "Développeur Full Stack" curriculum, module #AD10C.

## Project Structure

- `Vagrantfile`: Defines the entire infrastructure and container configurations.
- `Dockerfile`: Specifies the custom Debian image with SSH pre-configured.
- `scripts/`:
  - `start_ssh.sh`: Initializes SSH services in all containers.
  - `connect_ssh.sh`: Tests SSH connectivity between all containers.
  - `run_scripts.sh`: Executes the above scripts after Vagrant up.

## Infrastructure Components

- Gateway
- Load Balancer
- Web Servers (2)
- Database Servers (2)
- Logging Server
- Monitoring Server
- Bastion Host

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
   ssh -i ~/.ssh/id_rsa root@localhost -p 2231
   ```

## Current Status

- All containers are successfully created and running.
- SSH services are properly configured and starting on all containers.
- Full SSH connectivity is established between all containers, including the bastion host.

## Next Steps

- Configure HAProxy on the load balancer container.
- Set up web servers (e.g., Apache or Nginx) on web1 and web2.
- Implement database replication between db1 and db2.
- Configure logging and monitoring services.
- Implement network security measures and firewall rules.
- Deploy the target application (e.g., WordPress).
