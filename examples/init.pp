$dirs       = ["/somedir/appdir-1.2.3", "/shared/conf/", "/shared/data/", "/shared/log"]
$want_user  = "app"
$want_group = "app"

#
# testcase setup
#

user { $want_user:
  ensure => present,
}

group { $want_group:
  ensure => present,
}

file { ["/somedir", "/shared"]:
  ensure => directory 

file { $dirs:
  ensure => directory,
  mode   => "0755",
}

#
# resource under test
#

chown_r { $dirs:
  want_user  => $want_user,
  want_group => $want_group,
}
