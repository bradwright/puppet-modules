class sudo {

  group { 'sudo':
    ensure => present,
  }

  package { sudo:
    ensure  => latest,
    require => Group['sudo']
  }

  file { '/etc/sudoers':
    owner   => root,
    group   => root,
    mode    => 440,
    source  => "puppet:///modules/sudo/sudoers",
    require => Package['sudo'],
  }

}
