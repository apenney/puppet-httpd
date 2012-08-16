class httpd::config(
  $ssl,
  $passenger,
  $certificate = '',
  $key = '',
) {

  # TODO: Improve this.
  if $ssl == 'present' {
    if ($certificate == '') or ($key == '') {
      err('You must pass in either $certificate or $key to httpd::site{} when using ssl')
    } else {
      class { 'httpd::config::ssl':
        certificate => $certificate,
        key         => $key,
      }
    }
  }

  firewall { '001 apache ports':
    proto  => 'tcp',
    dport  => [ '443', '80' ],
    action => 'accept',
  }

  # Enable mod_status.
  file { '/etc/httpd/conf.d/status.conf':
    ensure => present,
    source => 'puppet:///modules/httpd/status.conf.erb',
    notify => Class['httpd::service'],
  }

  collectd::add_monitor { 'apache':
    ensure          => 'present',
    template_source => 'httpd/collectd_apache.conf.erb',
    plugin          => 'collectd-apache',
  }

}
