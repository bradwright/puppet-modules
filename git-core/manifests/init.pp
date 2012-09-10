# Installs most recent stable Git from the git-core team PPA
class git-core {
  apt::repository { 'git-git-core':
    type  => 'ppa',
    owner => 'git-core',
    repo  => 'ppa',
  }

  package { 'git':
    ensure => installed,
  }

  package { 'git-core':
    ensure  => purged,
    require => Package['git']

  }
}
