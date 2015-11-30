##simple manifest to get the master up and running:
node default {
  class { '::ospuppet::server':
#    webserver_ssl_host => '192.168.20.5',
#    webserver_ssl_port => '8140',
  
  }
}
