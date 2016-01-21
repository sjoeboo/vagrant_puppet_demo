class profile::base {
  #All hosts export thier ssh hostkey
  @@sshkey { $::hostname:
    ensure       => present,
    type         => 'rsa',
    key          => $::sshrsakey,
    host_aliases => [$::hostname,$::fqdn,$::ipaddress],
  }

  #All hosts collect the hostkeys
  Sshkey <<| |>>

  @@host { $::hostname:
    ensure       => present,
    ip           => $::ipaddress_enp0s8,
    host_aliases => [$::hostname,$::fqdn,$::ipaddress_enp0s8],
  }
  Host <<| |>>


  #agents CAN run checks (standalone mode), or the server can tell them to run them(pubsub)
  $sensu_checks=hiera('sensu_checks',{})
  create_resources(sensu::check, $sensu_checks)

  #the server does things w/ the handlers...
  $sensu_handlers=hiera('sensu_handlers',{})
  create_resources(sensu::handler, $sensu_handlers)

  $sensu_plugins=hiera('sensu_plugins',[])
  sensu::plugin{$sensu_plugins:
    type  => package,
    pkg_provider  => sensu_gem
  }
}
