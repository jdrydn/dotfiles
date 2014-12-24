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

Without any arguments, this script will output a list of the potential servers you can connect to:

```sh
$ ssh-server
List of servers to SSH to:
 [==]  name-of-server (root@some.ip.of.that.server with a password)
 [==]  name-of-other-server (some_user@some.ip.of.this.server with a key)
 [==]  name-of-yet-another-server (ubuntu@some.ip.of.the.server with a key)
```

With a single argument, this script will execute the relevant SSH command. If a key is provided (and I hope a key is 
provided!) then the command will execute instantly. If a password is provided the script will echo out the password for
you to copy and paste!

```sh
$ ssh-server name-of-server 
root@some.ip.of.that.server with a password 'a1b2c3d4e5f6'
root@12.345.678.9's password:
Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-37-generic x86_64)
# root at name-of-server in ~ [20:14:23]
```

```sh
$ ssh-server name-of-other-server
some_user@name-of-other-server with a key
Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-37-generic x86_64)
$ some_user at name-of-other-server in ~ [20:15:43]
```