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
    source  => "puppet:///modules/sudo/sudoers.${::lsbdistcodename}",
    require => Package['sudo'],
  }

  if $::lsbdistcodename == 'precise' {
    file { '/etc/sudoers.d/local':
      owner   => root,
      group   => root,
      mode    => 440,
      content => "%sudo ALL=(ALL) NOPASSWD: ALL",
      require => File['/etc/sudoers'],
    }
  }

}
