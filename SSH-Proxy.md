# SSH Proxy

```sh
$ ssh -D 12345 someuser@someserver.com
```

Now go set up a SOCKS proxy (System Preferences &raquo; Network &raquo; {Current Network
setting} &raquo; Proxies &raquo; SOCKS proxy) and set it to:

```
locahost:12345
```

`Apply` and `Apply`, and browse!