define httpd::site(
  $template,
  $ensure    = 'present',
  $docroot   = '/var/www/html',
  $passenger = 'absent',
  $ssl       = 'absent',
  $mod_wsgi  = 'absent',
) {

  class { 'httpd':
    ssl       => $ssl,
    passenger => $passenger,
    mod_wgi   => $mod_wsgi,
  }

  file { "/etc/httpd/conf.d/${name}.conf":
    ensure  => $ensure,
    content => template($template),
  }

}
