class httpd::install(
  $ssl,
  $passenger,
  $mod_wsgi,
) {

  package { 'httpd':
    ensure => present,
  }

  package { 'mod_ssl':
    ensure => $ssl,
  }

  package { 'mod_wsgi':
    ensure => $mod_wsgi,
  }

  class { 'passenger':
    enabled => $passenger,
  }

}
