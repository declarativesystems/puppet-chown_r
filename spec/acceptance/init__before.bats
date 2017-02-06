# BATS test file to run before executing 'examples/init.pp' with puppet.
#
# For more info on BATS see https://github.com/sstephenson/bats

# Tests are really easy! just the exit status of running a command...
@test "/tmp/foo managed permissions" {
  [[ $(stat -c %U /tmp/foo) == "root" ]]
}

@test "/tmp/foo/bar managed permissions" {
  [[ $(stat -c %U /tmp/foo/bar) == "root" ]]
}

@test "/tmp/foo/bar/baz managed permissions" {
  [[ $(stat -c %U /tmp/foo/bar/baz) == "root" ]]
}

@test "/tmp/foo/inky default owner" {
  [[ $(stat -c %U /tmp/foo/inky) == "root" ]]
}

@test "/tmp/foo/blinky default owner" {
  [[ $(stat -c %U /tmp/foo/blinky) == "root" ]]
}

@test "/tmp/foo/bar/pinky default owner" {
  [[ $(stat -c %U /tmp/foo/bar/pinky) == "root" ]]
}

@test "/tmp/foo/bar/baz/clyde default owner" {
  [[ $(stat -c %U /tmp/foo/bar/baz/clyde) == "root" ]]
}

@test "/tmp/notouch default owner" {
  [[ $(stat -c %U /tmp/notouch) == "bob" ]]
}

@test "/tmp/foo/skipdir default owner" {
  [[ $(stat -c %U /tmp/foo/skipdir) == "bob" ]]
}

@test "/tmp/foo/skipdir/skipfile default owner" {
  [[ $(stat -c %U /tmp/foo/skipdir/skipfile) == "bob" ]]
}
