class apt($source_list = true) {

  if $source_list {

    file { '/etc/apt/sources.list':
      ensure => present,
      source => "puppet:///modules/apt/sources.list.${::lsbdistcodename}",
    }

    file { '/etc/apt/sources.list.d':
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      ignore  => '*.save'

    }
  }

  # XXX: this is a brute force way to get python-software-properties
  # into the local apt-cache, which it isn't in certain precise
  # builds.
  exec { 'update':
    command => '/usr/bin/apt-get update',
    before => Package['python-software-properties']
  }

  package { 'python-software-properties':
    ensure => installed,
    tag    => 'no_require_apt_update',
  }

  class { 'apt::update': }

  Class['apt::update'] -> Package <| provider != pip and provider != gem and ensure != absent and ensure != purged and tag != 'no_require_apt_update' |>

}
