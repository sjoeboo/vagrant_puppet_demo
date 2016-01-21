class profile::zabbix::server {
  class { 'postgresql::server': }
  class { 'apache':
    mpm_module         => 'prefork',
  }
  include apache::mod::php
  class {'zabbix':
    zabbix_url        => $::ipaddress_enp0s8,
    listenip          => '*',
    sourceip          => $::ipaddress_enp0s8,
  }
}
