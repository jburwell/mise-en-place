# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-EOF
  cd /root
  ln -s /vagrant ./.mise
  cd .mise
  ./bootstrap-debian.sh
EOF

Vagrant.configure("2") do |config|

  config.vm.box = "bento/debian-9.4"

  config.vm.provision "shell", inline: $script

end
