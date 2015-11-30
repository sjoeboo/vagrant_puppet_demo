Vagrant.configure(2) do |config|
  #"Master" System 
  config.vm.define "master" do |master|
    master.vm.box = "sjoeboo/centos-7-1-x86-PC1"
    master.vm.network "private_network", type: "dhcp"
    master.vm.provision "shell", inline: <<-SHELL
      cd /vagrant;sudo PATH=$PATH:/opt/puppetlabs/bin/ /usr/local/bin/librarian-puppet install --verbose --path=/etc/puppetlabs/code/environments/production/modules/
    SHELL
  end

  #Slave-1 System
  config.vm.define "slave01" do |slave01|
    slave01.vm.box = "sjoeboo/centos-7-1-x86-PC1"
    slave01.vm.network "private_network", type: "dhcp"
  end
end
