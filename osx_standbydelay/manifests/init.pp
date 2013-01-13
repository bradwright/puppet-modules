# Updates the default hard standby limit described in:
#   http://support.apple.com/kb/HT4392
# Fix is here:
#   http://www.ewal.net/2012/09/09/slow-wake-for-macbook-pro-retina/
class osx_standbydelay($delay='4200') {
  if $::macosx_productversion_major == '10.8' {
    exec { 'update mountain lion standbydelay':
      command => "pmset -a standbydelay ${delay}",
      unless  => "pmset -g | grep standbydelay | awk '{print $2}' | grep -Fqe ${version}";
    }
  }
}
