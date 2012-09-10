# Installs Emacs from source using the .tar.gz file.
class emacs::src($version) {
  package { ['libncurses-dev', 'texinfo']:
    ensure => installed,
    before => Exec['install emacs']
  }

  file { '/tmp/install-emacs.sh':
    ensure  => present,
    content => template('emacs/install.sh.erb'),
    before  => Exec['install emacs'],
    mode    => '0755',
  }

  exec { 'install emacs':
    command => '/tmp/install-emacs.sh',
    # need unlimited timeout because the build takes ages
    timeout => 0,
    unless  => "test -f /usr/local/bin/emacs && /usr/local/bin/emacs --version | head -n 1 | grep -Fqe '${version}'"
  }

  package { 'emacs':
    ensure => purged
  }
}
