class httpd::params {

  $ssl = hiera(httpd_ssl, 'absent')
  $passenger = hiera(httpd_passenger, 'absent')
  $mod_wsgi = hiera(httpd_mod_wsgi, 'absent')
  $confdir = '/etc/httpd/conf.d'

}
