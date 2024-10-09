# AD10C - Linux for the Web

This project implements a scalable and secure web hosting infrastructure using Docker containers and Vagrant for orchestration. It's designed as part of the "Full Stack Developer" curriculum, module #AD10C.

## Current Architecture

Our current setup consists of:

- A public network containing:
    - Bastion (Jump Box)
    - Firewall
    - Load Balancer
    - Web Servers (Web1, Web2)
- A private network containing:
    - Database Servers (DB1, DB2)
    - Logs Server
    - Monitoring Server

The firewall container acts as a bridge between the public and private networks.

## How It Works

1. **Network Segregation**: We use two Docker networks (public and private) to segregate our infrastructure.
2. **Bastion Host**: All external SSH connections go through the bastion host, which is the only publicly accessible entry point.
3. **Firewall**: Acts as a gateway between public and private networks, controlling traffic flow.
4. **SSH Key Authentication**: All inter-container communication uses SSH key authentication for enhanced security.
5. **Automated Setup**: Vagrant and custom scripts automate the entire infrastructure setup.

## Setup Instructions

1. Ensure you have Vagrant and Docker installed on your system.
2. Clone this repository:
   ```
   git clone https://github.com/your-username/ad10c-linux-pour-le-web.git
   cd ad10c-linux-pour-le-web
   ```
3. Run Vagrant to set up the environment:
   ```
   vagrant up
   ```
4. Once setup is complete, you can access the bastion host:
   ```
   ssh -i ~/.ssh/id_rsa root@localhost -p 2208
   ```

## Accessing Containers

- From your local machine, you can only directly access the bastion.
- From the bastion, you can access public network containers directly:
  ```
  ssh web1
  ssh web2
  ssh firewall
  ssh loadbalancer
  ```
- To access private network containers, use the firewall as a jump host:
  ```
  ssh -J firewall db1
  ssh -J firewall db2
  ssh -J firewall logs
  ssh -J firewall monitoring
  ```

## Project Structure

- `Vagrantfile`: Defines the entire infrastructure and container configurations.
- `Dockerfile`: Specifies the custom Debian image with SSH and necessary packages pre-configured.
- `scripts/`:
    - `start_ssh.sh`: Initializes SSH services in all containers.
    - `update_hosts.sh`: Updates /etc/hosts files in all containers.
    - `setup_ssh_keys.sh`: Sets up SSH key-based authentication between containers.
    - `configure_firewall.sh`: Configures iptables rules on the firewall container.
    - `setup_routing.sh`: Sets up routing between networks.
    - `run_scripts.sh`: Orchestrates the execution of all scripts.

## Next Steps

- Implement specific services on each container (web servers, databases, etc.)
- Set up HAProxy on the load balancer
- Configure logging and monitoring services
- Implement additional security measures

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or encounter any problems.

