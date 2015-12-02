Vagrant.configure(2) do |config|
  #"Master" System
  config.vm.define "master" do |master|
    master.vm.box = "sjoeboo/centos-7-1-x86-PC1"
    master.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
    master.vm.network "private_network", ip: "192.168.20.5"
    master.vm.provision "shell", inline: <<-SHELL
      hostname master.vagrant
      echo "192.168.20.5  master.vagrant master" >> /etc/hosts
      systemctl stop firewalld; iptables -F

      #Setup Puppetserver A little bit more (would typically come from a control-repo
      sudo ln -svf /vagrant/puppet_code/hiera.yaml /etc/puppetlabs/code/hiera.yaml
      sudo ln -svf /vagrant/autosign.conf /etc/puppetlabs/puppet/autosign.conf
      sudo ln -svf /vagrant/puppet_code/environments/production/environment.conf /etc/puppetlabs/code/environments/production/environment.conf
      sudo ln -svf /vagrant/puppet_code/environments/production/site.pp  /etc/puppetlabs/code/environments/production/site.pp
      sudo ln -svFf /vagrant/puppet_code/environments/production/site  /etc/puppetlabs/code/environments/production/
      sudo ln -svFf /vagrant/puppet_code/environments/production/dist /etc/puppetlabs/code/environments/production/
      sudo ln -svFf /vagrant/puppet_code/environments/production/hieradata/nodes /etc/puppetlabs/code/environments/production/hieradata/
      sudo ln -sf /vagrant/puppet_code/environments/production/hieradata/common.yaml /etc/puppetlabs/code/environments/production/hieradata/common.yaml

      #Pull in puppet modules to bootstrap/use
      cd /vagrant;sudo PATH=$PATH:/opt/puppetlabs/bin/ /usr/local/bin/librarian-puppet install --verbose --path=/etc/puppetlabs/code/environments/production/modules/

      #Local Puppet Apply to bootstrap puppetserver
      sudo /opt/puppetlabs/bin/puppet apply --modulepath=/etc/puppetlabs/code/environments/production/modules/ master.pp

      #Now that we have a server up, we can run as an agent to do the rest!
      sudo /opt/puppetlabs/bin/puppet agent --test --server=master.vagrant;true
    SHELL
  end
  config.vm.define "foreman" do |foreman|
    foreman.vm.box = "sjoeboo/centos-7-1-x86-PC1"
    foreman.vm.network "private_network", ip: "192.168.20.10"
    foreman.vm.provision "shell", inline: <<-SHELL
      echo "192.168.20.5  master.vagrant master" >> /etc/hosts
      hostname foreman.vagrant
      echo "192.168.20.10 foreman.vagrant foreman" >>/etc/hosts
      sudo yum -y remove puppet
      sudo rm -rf /etc/yum.repos.d/puppet*
      sudo yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
      sudo yum -y install puppet 
      sudo puppet agent --test --server=master.vagrant;true
    SHELL
  end
  #Slave01 System
  config.vm.define "slave01" do |slave01|
    slave01.vm.box = "sjoeboo/centos-7-1-x86-PC1"
    slave01.vm.network "private_network", ip: "192.168.20.6"
    slave01.vm.provision "shell", inline: <<-SHELL
      echo "192.168.20.5  master.vagrant master" >> /etc/hosts
      hostname slave01.vagrant
      sudo /opt/puppetlabs/bin/puppet agent --test --server=master.vagrant;true
    SHELL
  end
  #Slave02 System
  config.vm.define "slave02" do |slave02|
    slave02.vm.box = "sjoeboo/centos-7-1-x86-PC1"
    slave02.vm.network "private_network", ip: "192.168.20.7"
    slave02.vm.provision "shell", inline: <<-SHELL
      echo "192.168.20.5  master.vagrant master" >> /etc/hosts
      hostname slave02.vagrant
    SHELL
  end

end
