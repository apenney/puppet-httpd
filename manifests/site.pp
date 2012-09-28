define httpd::site(
  $ensure      = 'present',
  $template    = 'httpd/generic-template.conf.erb',
  $docroot     = '/var/www/html',
  $passenger   = 'absent',
  $ssl         = 'absent',
  $mod_wsgi    = 'absent',
  $admin       = 'syseng@perimeterusa.com',
  $certificate = '',
  $key         = '',
  $subscribes  = '',
  $requires    = '',
) {

  class { 'httpd':
    ssl       => $ssl,
    passenger => $passenger,
    mod_wsgi   => $mod_wsgi,
  }

  file { "${httpd::params::confdir}/${name}.conf":
    ensure  => $ensure,
    content => template($template),
  }

}
