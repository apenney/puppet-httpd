class httpd::service(
  $subscribes,
  $requires
) {

  service { 'httpd':
    ensure  => true,
    enable  => true,
  }

  if $requires != '' {
    Service['httpd'] {
      require +> $requires,
    }
  }

  if $subscribes != '' {
    Service['httpd'] {
      subscribe +> $subscribes,
    }
  }

}
