# chown_r
# Defined Resource Type to carry out chown -R when required.  This avoids 
# having to use recursive `file` resources with large directories as this 
# can bring about poor performance in the Puppet Master as well as placing
# high demand on storage requirements
# 
#
# Params
# ======
#   [`dir`]
#     The directory to check and chown.  Defaults to $name
#   [`want_user`]
#     The user ID to chown to and check for
#   [`want_group`]
#     the group ID to chown to and check for
#   [`watch`]
#     Resource reference to watch (eg Package['foo']), if set, we will only
#     run the chown if this resource sends a refresh event AND we identify
#     files with incorrect ownership.  Note that if this parameter is not set,
#     the chown command will run every time find tells us we need to (eg
#     every puppet run)
define chown_r(
  $want_user,
  $want_group,
  $dir = $name,
  $watch = false,
) {

if $watch {
  $refreshonly  = true
  $_watch       = $watch
} else {
  $refreshonly  = false
  $_watch       = undef
}

# change ownership if find matches any files or directories with different
# ownership to $want_user or $want_group
exec { "chown -R for ${dir}":
  command     => "chown -R ${want_user}:${want_group} ${dir}",
  refreshonly => $refreshonly,
  onlyif      => "find ${dir} \\( -not -user ${want_user} -or -not -group ${want_group} \\) | grep .",
  subscribe   => $_watch,
  path        => [
    "/bin",
    "/usr/bin",
  ],
}

}
