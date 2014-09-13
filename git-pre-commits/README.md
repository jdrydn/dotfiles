# Git Pre-Commit Hooks

Useful pre-commit hooks I like to have in projects!

To enable them, go to your local repository and:

```bash
$ cd .git/hooks
$ mv pre-commit.sample pre-commit # If you don't have a pre-commit hook already.
$ vim pre-commit
```

```bash
#!/bin/sh => #!/bin/bash
```

```bash
# Validate PHP files
source ~/.dotfiles/git-pre-commits/phplinter.sh
```

