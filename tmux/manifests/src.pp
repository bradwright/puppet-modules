# Installs tmux from source by download a tarball from Sourceforge.
# See the install.sh.erb template for most of the download/unpacking
# logic.
class tmux::src($version) {
  package { ['libevent-dev', 'libncurses5-dev']:
    ensure => installed,
    before => Exec['install tmux']
  }

  file { '/tmp/install-tmux.sh':
    ensure  => present,
    content => template('tmux/install.sh.erb'),
    before  => Exec['install tmux'],
    mode    => '0755'
  }

  exec { 'install tmux':
    command => '/tmp/install-tmux.sh',
    # need unlimited timeout because the build takes ages
    timeout => 0,
    unless  => "test -f /usr/local/bin/tmux && /usr/local/bin/tmux -V | head -n 1 | grep -Fqe '${version}'"
  }

  package { 'tmux':
    ensure => purged
  }
}
