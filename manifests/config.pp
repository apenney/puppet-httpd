class httpd::config(
  $ssl,
  $passenger,
  $certificate,
  $key,
) inherits httpd::params {

  # TODO: Improve this.
  if $ssl == 'present' {
    if ($certificate == '') or ($key == '') {
      err('certificate and key parameters must be non-empty')
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
  file { "${httpd::params::confdir}/status.conf":
    ensure => present,
    source => 'puppet:///modules/httpd/status.conf.erb',
    notify => Class['httpd::service'],
  }

  # Ensure collectd is actually enabled.
  include collectd::client

  collectd::add_monitor { 'apache':
    ensure          => 'present',
    template_source => 'httpd/collectd_apache.conf.erb',
    plugin          => 'collectd-apache',
  }

}
