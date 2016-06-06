# chown_r

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with chown_r](#setup)
    * [What chown_r affects](#what-chown_r-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with chown_r](#beginning-with-chown_r)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module provides a handy way to run the `chown -R` command to perform bulk directory ownership/group changes where required.

While the equivalent result is also possible using a `file` resource in recursive mode, doing so can create a huge number of resources, placing an unnecessary load on the Puppet Master.

This module achieves the same result at the cost of reduced change reporting granularity:  A  maximum of one change per resource will ever be reported no matter how many underlying files need to have their ownership fixed.  This is inline with the default behavior of the underlying `chown` system command.


## Usage
### Notes
* Directories referred to must already exist on the system
* If creating these directories with Puppet, you should not specify owner or group information as this could conflict with the changes made by this module
* Any groups and users required must be declared
* You can pass an array of directories to check and fix recursively for permissions to save typing as long as the `want_user` and `want_group` fields are identical
* Both `want_user` and `want_group` are mandatory parameters

### Check permissions every puppet run
If your happy for Puppet to update and fix permissions as required, the following code would ensure that `/foo` and all its children are owned by user `foo` and group `foo`:
```puppet
chown_r { "/foo":
  want_user   => "foo",
  want_group  => "foo",
}
```

### Check permissions when watched resource changes
If your only ever want to perform fixes in response to a Package update AND observed incorrect ownership, the following code would ensure all `/bar` and all its children will be set to owner `bar`, group `bar` if required after a change to the `foobar` package.  If the package is unchanged, then ownership will not be checked/fixed.
```puppet
chown_r { "/bar":
  want_user   => "bar",
  want_group  => "bar",
  watch       => Package["foobar"],
}
```

### Checking and fixing permissions on several directories at once
If you have several directories to check/fix, you can use Puppet's built in array syntax as follows to reduce the amount of typing needed.  You may also specify a resource to watch for changes as desired.
```puppet
chown_r { ["/somedir/appdir-1.2.3", "/shared/conf/", "/shared/data/", "/shared/log"]:
  want_user   => "app",
  want_group  => "app",
}
```

## Reference

* `chown_r` -- Defined resource type providing `chmod -R`-like capabilities

## Limitations
* Only works on Unix-like OS's
* It's possible to write code that will result in race conditions using this module, please test your code thoroughly
* Both `want_user` and `want_group` must be set at the time of use
* Overlapping `chown_r` resources are not detected by the module and must be avoided by the user

## Development
Pull Requests accepted
