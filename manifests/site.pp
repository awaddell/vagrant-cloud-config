# -*- mode: ruby -*-
# vi: set ft=ruby :

class { 'timezone':
	timezone => 'UTC',
	ensure => present,
}

class { 'mysql::client': }

class { 'firewall': }

package { 'hping3':
        ensure => present,
}
if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}