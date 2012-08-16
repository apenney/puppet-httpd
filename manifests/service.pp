class httpd::service {

  service { 'httpd':
    ensure  => true,
    enable  => true,
    require => [ Class['httpd::config'], Class['httpd::install'] ],
  }

}
