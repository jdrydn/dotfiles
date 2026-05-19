# SSH

## SSH keys

```sh
$ ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```

## SSH config

```sh
$ vim ~/.ssh/config
```

```sshconfig
# Setting common usernames for common domains
# This lets us do git clone github.com:$OWNER/$REPO
# (Without needing to specify `git@github.com` every single time)
Host github.com
  User git
Host gitlab.com
  User git
Host bitbucket.org
  User git

# ssh github.com
#   (1) ssh git@github.com
# git clone github.com:jdrydn/dotfiles
#   (1) git clone git@github.com
```

```sshconfig
# Specific server definitions
Host upstairs-pc
  Hostname 192.168.1.103
  IdentityFile ~/.ssh/upstairs_pc
  User ubuntu

# ssh upstairs-pc
#   (1) ssh -i ~/.ssh/upstairs_pc ubuntu@192.168.1.103
```

```sshconfig
# Specific server definition via another machine
Host remote-mainframe-station
  # Specify the initial connection to make
  ProxyCommand ssh -q -W %h:%p upstairs-pc
  AddressFamily inet
  # Then the details of the connection to make afterwards
  Hostname ec2-12-345-67-89.compute.amazonaws.com
  IdentityFile ~/.ssh/mainframe_rsa
  User ubuntu

  # Could also specify an SSH command inline
  ProxyCommand ssh -q -W %h:%p -i ~/.ssh/aws_rsa ec2-user@ec2-98-765-43-21.compute.amazonaws.com

# ssh remote-mainframe-station
#   (1) ssh -q -i ~/.ssh/aws_rsa ec2-user@ec2-98-765-43-21.compute.amazonaws.com
#   (2) ssh -i ~/.ssh/mainframe_rsa ubuntu@ec2-12-345-67-89.compute.amazonaws.com
```
