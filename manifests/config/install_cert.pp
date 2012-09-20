define httpd::config::install_cert(
  $certdir = $httpd::params::certdir,
) {

  $installname = regsubst($name,'/(.*)$','\1')

  @file { "$certdir/$installname":
    ensure  => present,
    source  => "puppet:///modules/$name",
    require => File[$certdir],
    tag     => 'apache_cert',
  }

}
