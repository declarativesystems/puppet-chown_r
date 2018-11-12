# @PDQTest

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

file { ["/somedir", "/shared", "/foo", "/extra"]:
  ensure => directory,
}

file { $dirs:
  ensure => directory,
  mode   => "0755",
}

package { "nmap-ncat":
  ensure => present,
}

#
# resources under test
#

# chown only if watched package changes
chown_r { "/foo/bar":
  want_user  => $want_user,
  want_group => $want_group,
  watch      => Package["nmap-ncat"],
}


# chown if needed
chown_r { $dirs:
  want_user  => $want_user,
  want_group => $want_group,
}

chown_r { "/extra":
  want_user  => $want_user,
}

chown_r { '/foo':
  want_group => $want_group,
}

chown_r { '/bar':
  want_group => $want_group,
  watch      => User[$want_user],
}

chown_r { '/baz':
  want_group => $want_group,
  watch      => [User[$want_user], Group[$want_group]],
}
