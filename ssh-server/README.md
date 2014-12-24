# SSH-Server

A simple script to allow me to have multiple SSH server listings without clouding up my SSH config.

Example usage:

```sh
$ cd /path/to/a/working/directory
$ ssh-server live
```

```sh
$ cd /path/to/another/working/directory
$ ssh-server rs-web1
```

```sh
$ cd /path/to/yet/another/working/directory
$ ssh-server aws-database2
```

----

This requires a specific ini file containing the following:

```ini
[name-of-server]
host = some.ip.of.that.server
user = root
pass = a1b2c3d4e5f6

[name-of-other-server]
host = some.ip.of.that.server
user = some_user
key = other_server_rsa

[name-of-yet-another-server]
host = some.ip.of.that.server
user = ubuntu
key = ~/.ssh/id_rsa
```

There must be a `host`, a `user` field and either a `pass` (password) or `key` field, containing a password or a path to
a file (respectively). If the key is missing a prefix (either `~/` or `/`) then the key file is relative to the current
working directory.