#!/bin/bash
# If this file exists it will be run on the system under test before puppet runs
# to setup any prequisite test conditions, etc
#!/bin/bash
# create a tree of files with default ownership
useradd bob
useradd charles
mkdir -p /tmp/foo/bar/baz/
touch /tmp/foo/inky
touch /tmp/foo/blinky
touch /tmp/foo/bar/pinky
touch /tmp/foo/bar/baz/clyde
touch /tmp/notouch
chown bob:bob /tmp/notouch
mkdir /tmp/foo/skipdir
chown bob:bob /tmp/foo/skipdir
touch /tmp/foo/skipdir/skipfile
chown bob:bob /tmp/foo/skipdir/skipfile
