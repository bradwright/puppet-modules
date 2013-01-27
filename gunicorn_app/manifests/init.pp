Exec { path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' }

# Installs a Python application run using Gunicorn. Ubuntu only, as it
# uses upstart to run the service.
class gunicorn_app(
  $name='gunicorn_app',
  $port=8000,
  $workers=2,
  $app_path='/var/www/gunicorn_app',
  $settings_path='/var/www/gunicorn_app/settings.py',
  $gunicorn_bin='gunicorn'
  ) {

  file { '/var/run/gunicorn':
    ensure => directory,
    owner  => 'www-data',
  }

  file { '/etc/gunicorn':
    ensure => directory,
    owner  => root,
  }

  $config_path = "/etc/gunicorn/${name}.py"

  file { "${name}.gunicorn.py":
    ensure  => present,
    path    => $config_path,
    content => template('gunicorn_app/gunicorn.py.conf'),
    owner   => root,
    group   => root,
    require => [File['/etc/gunicorn'], File['/var/run/gunicorn']]
  }

  file {"${name}.upstart.conf":
    ensure  => present,
    path    => "/etc/init/${name}_gunicorn.conf",
    content => template('gunicorn_app/upstart.conf.erb'),
    owner   => root,
    group   => root,
    require => File["${name}.gunicorn.py"],
  }

  service {"${name}_gunicorn":
    ensure   => running,
    provider => upstart,
    require  => File["${name}.upstart.conf"],
  }
}
