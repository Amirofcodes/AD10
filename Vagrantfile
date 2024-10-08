# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.image = "custom-debian-ssh"
    d.has_ssh = false
    d.remains_running = true
    d.cmd = ["tail", "-f", "/dev/null"]
  end

  machines = {
    "gateway" => 2223,
    "loadbalancer" => 2224,
    "web1" => 2225,
    "web2" => 2226,
    "db1" => 2227,
    "db2" => 2228,
    "logging" => 2229,
    "monitoring" => 2230,
    "bastion" => 2231
  }

  machines.each do |machine, ssh_port|
    config.vm.define machine do |node|
      node.vm.provider "docker" do |d|
        d.name = "ad10_#{machine}"
        d.ports = ["127.0.0.1:#{ssh_port}:22"]
      end
    end
  end

  config.trigger.after :up do |trigger|
    trigger.name = "Run scripts"
    trigger.run = {path: "scripts/run_scripts.sh"}
  end
end
