# httpd                                                                                                                                                     
## Overview                                                                   
                                                                              
This module has a number of classes that are designed to be accessed via a define, httpd::site{}.  ::site can be modified to add in support for various features of apache and currently handles:                                         
                                                                              
 * SSL                                                                        
 * mod_wsgi                                                                   
 * Custom config templates.                                                   
 * Passing in requires and subscribes so that httpd can auto-restart if needed or fail to start until other things are setup.

## Classes

### httpd

This class is the major class that calls all the subclasses for features.  Features are enabled or disabled by passing in parameters to httpd.  These are generally 'present' or 'absent' toggles and when adding features you should take the time to add a validate_re line to ensure that only those two values are accepted.

### httpd::install

This class installs the various packages.  It uses the present/absent of features to decide what to install.  This pattern allows us to remove packages and features as well as install them.

### httpd::config

This class is a little trickier.  If you enabled $ssl in httpd then we must ensure you pass in a $certificate and $key (or array of).  We check for this and include httpd::config::ssl and pass it the cert/key parameters if you have all three parameters done properly.

The rest of this class sets up firewall rules, enables mod_status for collectd and adds a collectd monitor for apache.

### httpd::service

This just makes sure the service is running and adds in the $subscribes or $requires you pass into site.pp to the service.

### httpd::config::ssl

This calls the defines for cert and key and then realizes the files at the end.

## Defines

### httpd::site

This is the main define that drives the module.  Mostly it takes in parameters and passes them to the httpd class.  In addition to this it creates the vhost's .conf file as $name.conf.  It uses the $docroot and various parameters that are passed into the main httpd site to construct an appropriate default vhost conf.  If you pass in $template then you can push a custom httpd configuration file.  By default it pulls in a generic one that tries to do the right thing based on the parameters.

### httpd::config::install_cert

This define will push out the cert and key files you defined earlier.  It defines the resources as virtual and then realizes them elsewhere to help in cases where you're pushing multiple sites via hiera and some share the same certs.

Written by Ashley Penney - apenney@perimeterusa.com
