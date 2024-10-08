FROM debian:bullseye

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    wget \
    nano \
    vim \
    iproute2 \
    iptables \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh \
    && echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDH+SLfasi+zSEeT2Y7VIGpkuhpfB3YHubJFL5OT35cLsHugqF+eLdTB08YBE6xpRFhCgQPKzI4ygYHno1Tg7aQc0NADsApEOCuE8wnknPL7RV1mOMA+auxyDN2P64C3pBMWluoGOJNAtgUqW8oiPppwxeSlGZbnL4yILsF3Df9LtPyF002UoYI6ZywHYEjy4toWbxFVPG8eRRbJE2QJzS+gYeTIlK7OnJdl43rawWD+DAMlJJi9LzzeyqAWcU+5HRvY7EWaoJkSDquqHGlPDkOhkknQ2VQTVv0aYQOOwTkz7iEk2rB3h9F0J+57X8U6xu3w3Lr8KGC5uBDW37l3fe4eSOpVsta1W/6dg3YypS34Q2hS/I+PTdgjA9fJhDK8+vS3+PMS7CvX71+9W8CAMzlWE5cL99R6PQOO8NOzzYOL98qEzmGkq/q2KfokcNsG6Kzvd3AqOcIxV5vGbWGaMmh6vIGiT6Vv3l8tGaZopRFDIz+psIO2Nv4gwJyBaqQn51wE/YB5HVbiloKpprBr1Z7ao7ewm7jQbBrl4cug2RBEnq7NmGEDJztKTsiPVCbd8rLBykpXIxCVvn0x0pWC/ZsnZXwXAnlek0ee9yNk1VRIWNIU1uwJXKfFmJdfdpM9YDrkHvuUQcmC5fX2w8XqAzBbBzCSRNOAEBp2oOMpb48IQ== vagrant@localhost' > /root/.ssh/authorized_keys \
    && chmod 600 /root/.ssh/authorized_keys \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && mkdir /var/run/sshd

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
