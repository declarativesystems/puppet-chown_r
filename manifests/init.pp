# @summary recursive chown
#
# Defined Resource Type to carry out chown -R when required.  This avoids
# having to use recursive `file` resources with large directories as this
# can bring about poor performance in the Puppet Master as well as placing
# high demand on storage requirements
#
#
# @param dir The directory to check and chown.  Defaults to $name
# @param want_user The user ID to chown to and check for
# @param want_group The group ID to chown to and check for
# @param watch Resource reference to watch (eg Package['foo']), if set, we will only
#   run the chown if this resource sends a refresh event AND we identify
#   files with incorrect ownership.  Note that if this parameter is not set,
#   the chown command will run every time find tells us we need to (eg
#   up to every puppet run)
# @param skip Do not include this directory when running chmod
# @param options Additional options to pass to the `chown` or `chgrp` command
define chown_r(
  Optional[String]                                          $want_user  = undef,
  Optional[String]                                          $want_group = undef,
  String                                                    $dir        = $name,
  Optional[Variant[Type[Resource], Array[Type[Resource]]]]  $watch      = undef,
  Optional[String]                                          $skip       = undef,
  Optional[String]                                          $options    = "-h",
) {

  if $watch {
    $refreshonly  = true
    $_watch       = $watch
  } else {
    $refreshonly  = false
    $_watch       = undef
  }

  # must use '!' instead of -not on solaris or we get a bad command error
  if $facts['os']['family'] == 'Solaris' {
    $not_pred  = '!'
    $or_pred   = '-o'
  } else {
    $not_pred  = '-not'
    $or_pred   = '-or'
  }

  if $skip {
    $_skip = "-wholename ${skip} -prune -o"
  } else {
    $_skip = ""
  }

  if $want_user {
    $_want_user = "${not_pred} -user ${want_user}"
  } else {
    $_want_user = ""
  }

  if $want_group {
    $_want_group = "${not_pred} -group ${want_group}"
  } else {
    $_want_group = ""
  }

  if $want_user and $want_group {
    $want_both = $or_pred
    $cmd = "chown ${options} ${want_user}:${want_group}"
  } elsif $want_user {
    $want_both = ""
    $cmd = "chown ${options} ${want_user}"
  } elsif $want_group {
    $want_both = ""
    $cmd = "chgrp ${options} ${want_group}"
  } else {
    fail("One of want_user or want_group must be specified")
  }

  # change ownership if find matches any files or directories with different
  # ownership to $want_user or $want_group
  exec { "chown -R for ${dir}":
    command     => "find ${dir} ${_skip} \\( ${_want_user} ${want_both} ${_want_group} \\) -exec ${cmd} {} \\;",
    refreshonly => $refreshonly,
    onlyif      => "find ${dir} ${_skip} \\( ${_want_user} ${want_both} ${_want_group} \\) -print | grep .",
    subscribe   => $_watch,
    path        => [
      "/bin",
      "/usr/bin",
      "/usr/sbin",
    ],
  }

}
