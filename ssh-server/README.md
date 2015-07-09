# SSH-Server

A simple script to allow me to have multiple SSH server listings without clouding up my SSH config.

Example usage:

```sh
$ cd /path/to/a/working/directory
$ sshserver
 [==] ssh-servers.ini located at /Users/James/Documents/KentProjects

  Where would you like to go?
 [1]  name-of-server (root@some.ip.of.that.server with a password)
 [2]  name-of-other-server (some_user@some.ip.of.this.server with a key)
 [3]  name-of-yet-another-server (ubuntu@some.ip.of.the.server with a key)

  Please choose [1..3]: 1
 [==] Connecting to root@some.ip.of.that.server with password 'a1b2c3d4e5f6'
root@12.345.678.9's password:
Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-37-generic x86_64)
# root at name-of-server in ~ [20:14:23]
```

This requires a specific ini file named `ssh-servers.ini` in any generic folder containing the following:

```ini
[name-of-server]
host = some.ip.of.that.server
user = root
pass = a1b2c3d4e5f6

[name-of-other-server]
host = some.ip.of.this.server
user = some_user
key = other_server_rsa

[name-of-yet-another-server]
host = some.ip.of.the.server
user = ubuntu
key = ~/.ssh/id_rsa
```

There must be a `host`, a `user` field and either a `pass` (password) or `key` field, containing a password or a path to
a file (respectively). If the key is missing a prefix (either `~/` or `/`) then the key file is relative to the current
working directory.

----

### Updates

Due to the difficulties I've been having with trying to get auto-competition working in `bash` and `zsh`, this script's
usage has had to change. Because typing long names of servers (like `name-of-yet-another-server`) sucks.

It used to be like:

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

It's now been rewritten to be a welcoming screen. Taken from the `welcome` screen, obviously.

```sh
$ sshserver
 [==] ssh-servers.ini located at /Users/James/Documents/KentProjects

  Where would you like to go?
 [1]  name-of-server (root@some.ip.of.that.server with a password)
 [2]  name-of-other-server (some_user@some.ip.of.this.server with a key)
 [3]  name-of-yet-another-server (ubuntu@some.ip.of.the.server with a key)

  Please choose [1..3]:
```

And when you select a number, it doesn't run the `ssh` process under a `php` process. Instead, the script continues to
`exec`ute the `ssh` command so that when `ssh` exits (for whatever reason) you are returned to the shell.
