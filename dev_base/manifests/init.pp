class dev_base(
  $source_list = true,
  $default_user = 'vagrant') {

  package {
    [
     'build-essential',
     'bash-completion',
     'curl',
     'zsh',
     'zsh-doc',
     'zsh-lovers',
     ]:
    ensure => installed
  }

  class { 'git-core': }

  class { 'emacs':
    version => "24.2"
  }

  include tmux

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
    before      => Exec[ 'make dotfiles' ],
    require     => Class[ 'git-core' ]
  }

  # check out my dotfiles repo as the logged in user
  git::clone { 'git emacs.d':
    repo        => "https://github.com/bradleywright/emacs-d.git",
    destination => "/home/${default_user}/src/emacs-d",
    user        => $default_user,
    before      => Exec[ 'make emacs.d' ],
    require     => Class[ 'git-core' ]
  }

  exec { 'make dotfiles':
    cwd      => "/home/${default_user}/src/dotfiles",
    # This is a dirty hack because you can't actually log in as the
    # user, even with the :user param.
    command  => "/bin/su -c 'TARGET=/home/${default_user}/ make' ${default_user}",
    creates  => "/home/${default_user}/.ackrc",
    provider => shell,
  }

  exec { 'make emacs.d':
    cwd      => "/home/${default_user}/src/emacs-d",
    # This is a dirty hack because you can't actually log in as the
    # user, even with the :user param.
    command  => "/bin/su -c 'make' ${default_user}",
    creates  => "/home/${default_user}/.emacs.d/init.el",
    provider => shell,
  }

  class { 'ack': }

  # Puppet always complains otherwise, see:
  # http://projects.puppetlabs.com/issues/9862
  group { "puppet":
    ensure => present
  }
}
