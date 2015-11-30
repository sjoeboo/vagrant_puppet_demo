class profile::base {
  #All hosts export thier ssh hostkey
  @@sshkey { $hostname:
    ensure => present,
    type => "rsa",
    key  => $sshrsakey,
    host_aliases => [$::hostname,$::fqdn,$::ipaddress],
  }

  #All hosts collect the hostkeys
  Sshkey <<| |>>

}
