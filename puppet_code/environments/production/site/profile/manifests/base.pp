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
}
