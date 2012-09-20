class dev_base(
  $source_list = true,
  $default_user = 'vagrant') {

  class { 'apt':
    source_list => $source_list
  }

  package {
    [
     'build-essential',
     'bash-completion',
     'curl',
     'zsh',
     'zsh-doc'
     ]:
    ensure => installed
  }

  class { 'git-core': }

  class { 'emacs':
    version => "24.2"
  }

  class { 'tmux':
    version => "1.6"
  }

  file { 'home src':
    ensure  => directory,
    path    => "/home/${default_user}/src",
    owner   => $default_user,
    group   => $default_user
  }

  # check out my dotfiles repo as the logged in user
  git::clone { 'git dotfiles':
    repo        => "https://github.com/bradleywright/dotfiles.git",
    destination => "/home/${default_user}/src/dotfiles",
    user        => $default_user,
    before      => Exec[ 'emacs.d fetch' ],
    require     => Class[ 'git-core' ]
  }

  exec { 'emacs.d fetch':
    cwd      => "/home/${default_user}/src/dotfiles",
    command  => "/bin/su -c 'git submodule update --init' ${default_user}",
    creates  => "/home/${default_user}/src/dotfiles/emacs.d/Makefile",
    provider => shell,
    before   => Exec[ 'make dotfiles' ],
  }

  exec { 'make dotfiles':
    cwd      => "/home/${default_user}/src/dotfiles",
    # This is a dirty hack because you can't actually log in as the
    # user, even with the :user param.
    command  => "/bin/su -c 'TARGET=/home/${default_user}/ make' ${default_user}",
    creates  => "/home/${default_user}/.ackrc",
    provider => shell,
  }

  class { 'ack': }

  # Puppet always complains otherwise, see:
  # http://projects.puppetlabs.com/issues/9862
  group { "puppet":
    ensure => present
  }
}
