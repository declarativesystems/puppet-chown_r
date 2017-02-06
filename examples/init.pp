# @PDQTest
chown_r { "/tmp/foo":
  want_user   => "nobody",
  want_group  => "charles",
  skip        => "/tmp/foo/skipdir",
}
