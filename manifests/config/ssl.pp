class httpd::config::ssl (
  $certificate,
  $key,
) {

  # Use a define to ensure that certificate and key can be an array.
  httpd::config::install_cert { $cert: }
  httpd::config::install_cert { $key: }

}
