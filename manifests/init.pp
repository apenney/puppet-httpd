class httpd(
  $ssl = $httpd::params::ssl,
  $passenger = $httpd::params::passenger,
  $mod_wsgi = $httpd::params::mod_wsgi,
) inherits httpd::params {

  class { 'httpd::install':
    ssl       => $ssl,
    passenger => $passenger,
    mod_wsgi  => $mod_wsgi,
  }

  class { 'httpd::config':
    ssl       => $ssl,
    passenger => $passenger,
  }

  include httpd::service

  Class ['httpd::install'] -> Class['httpd::config'] -> Class['httpd::service']

}
