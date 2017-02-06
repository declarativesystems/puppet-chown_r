# BATS test file to run after executing 'examples/init.pp' with puppet.
#
# For more info on BATS see https://github.com/sstephenson/bats

# Tests are really easy! just the exit status of running a command...
@test "/tmp/foo managed owner" {
  [[ $(stat -c %U /tmp/foo) == "nobody" ]]
}
@test "/tmp/foo managed group" {
  [[ $(stat -c %G /tmp/foo) == "charles" ]]
}

@test "/tmp/foo/bar managed owner" {
  [[ $(stat -c %U /tmp/foo/bar) == "nobody" ]]
}
@test "/tmp/foo/bar managed group" {
  [[ $(stat -c %G /tmp/foo/bar) == "charles" ]]
}

@test "/tmp/foo/bar/baz managed owner" {
  [[ $(stat -c %U /tmp/foo/bar/baz) == "nobody" ]]
}
@test "/tmp/foo/bar/baz managed group" {
  [[ $(stat -c %G /tmp/foo/bar/baz) == "charles" ]]
}

@test "/tmp/foo/inky managed owner" {
  [[ $(stat -c %U /tmp/foo/inky) == "nobody" ]]
}
@test "/tmp/foo/inky managed group" {
  [[ $(stat -c %G /tmp/foo/inky) == "charles" ]]
}

@test "/tmp/foo/blinky managed owner" {
  [[ $(stat -c %U /tmp/foo/blinky) == "nobody" ]]
}
@test "/tmp/foo/blinky managed group" {
  [[ $(stat -c %G /tmp/foo/blinky) == "charles" ]]
}

@test "/tmp/foo/bar/pinky managed owner" {
  [[ $(stat -c %U /tmp/foo/bar/pinky) == "nobody" ]]
}
@test "/tmp/foo/bar/pinky managed group" {
  [[ $(stat -c %G /tmp/foo/bar/pinky) == "charles" ]]
}

@test "/tmp/foo/bar/baz/clyde managed owner" {
  [[ $(stat -c %U /tmp/foo/bar/baz/clyde) == "nobody" ]]
}
@test "/tmp/foo/bar/baz/clyde managed group" {
  [[ $(stat -c %G /tmp/foo/bar/baz/clyde) == "charles" ]]
}

@test "/tmp/notouch not descended owner" {
  [[ $(stat -c %U /tmp/notouch) == "bob" ]]
}
@test "/tmp/notouch not descended group" {
  [[ $(stat -c %G /tmp/notouch) == "bob" ]]
}

@test "/tmp/foo/skipdir not descended owner" {
  [[ $(stat -c %U /tmp/foo/skipdir) == "bob" ]]
}
@test "/tmp/foo/skipdir not descended group" {
  [[ $(stat -c %G /tmp/foo/skipdir) == "bob" ]]
}

@test "/tmp/foo/skipdir/skipfile not descended owner" {
  [[ $(stat -c %U /tmp/foo/skipdir/skipfile) == "bob" ]]
}
@test "/tmp/foo/skipdir/skipfile not descended group" {
  [[ $(stat -c %G /tmp/foo/skipdir/skipfile) == "bob" ]]
}
