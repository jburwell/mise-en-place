# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-EOF
  MISE_HOME="$HOME/.mise"

  ln -s /vagrant "$MISE_HOME"
  cd "$MISE_HOME"
  ./bootstrap-debian.sh -d
EOF

Vagrant.configure("2") do |config|

  config.vm.box = "bento/debian-9.4"

  config.vm.provision "shell", inline: $script

end
