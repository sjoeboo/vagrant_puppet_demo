node default {
  hiera_include('classes',[])
  $firewall_rules=hiera('firewall_rules',{})
  create_resources(firewall, $firewall_rules)
  $packages=hiera('packages',[])
  package{$packages:
    ensure => installed
  }
}
