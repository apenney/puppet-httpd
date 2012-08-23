class httpd(
  $ssl         = $httpd::params::ssl,
  $passenger   = $httpd::params::passenger,
  $mod_wsgi    = $httpd::params::mod_wsgi,
  $certificate = '',
  $key         = '',
  $subscribes  = '',
  $requires    = '',
) inherits httpd::params {

  # Validate allowed parameters.
  $val = [ '^present$', '^absent$' ]
  validate_re($ssl, $val)
  validate_re($passenger, $val)
  validate_re($mod_wsgi, $val)

  class { 'httpd::install':
    ssl       => $ssl,
    passenger => $passenger,
    mod_wsgi  => $mod_wsgi,
  }

  class { 'httpd::config':
    ssl         => $ssl,
    passenger   => $passenger,
    certificate => $certificate,
    key         => $key,
  }

  class { 'httpd::service':
    subscribes => $subscribes,
    requires   => $requires,
  }

  Class ['httpd::install'] -> Class['httpd::config'] -> Class['httpd::service']

}
