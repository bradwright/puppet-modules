# Installs the absolute latest version of ack into the $target_dir
# passed in.
class ack(
  $target_dir='/usr/local/bin'
  ) {

  $ack_bin = "${target_dir}/ack"

  exec { 'install-ack':
    require  => Package['curl'],
    command  => "curl -s -o ${ack_bin} http://betterthangrep.com/ack-standalone",
    creates  => $ack_bin,
    provider => shell
  }

  file { $ack_bin:
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Exec['install-ack'],
  }
}
