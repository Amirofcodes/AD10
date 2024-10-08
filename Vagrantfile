# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.image = "custom-debian-ssh"
    d.has_ssh = false
    d.remains_running = true
  end

  # Define the machines
  machines = {
    "firewall" => { networks: ["public", "private"] },
    "loadbalancer" => { networks: ["public"] },
    "web1" => { networks: ["public"] },
    "web2" => { networks: ["public"] },
    "db1" => { networks: ["private"] },
    "db2" => { networks: ["private"] },
    "logs" => { networks: ["private"] },
    "monitoring" => { networks: ["private"] },
    "bastion" => { networks: ["public"] }
  }

  machines.each do |name, settings|
    config.vm.define name do |machine|
      machine.vm.hostname = name
      machine.vm.provider "docker" do |d|
        d.name = "ad10_#{name}"
        d.create_args = settings[:networks].map { |net| "--network=ad10_#{net}_network" }
      end
      machine.vm.network "forwarded_port", guest: 22, host: 2200 + machines.keys.index(name)
    end
  end

  config.trigger.after :up do |trigger|
    trigger.name = "Run scripts"
    trigger.run = {path: "scripts/run_scripts.sh"}
  end
end
