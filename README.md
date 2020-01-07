# dotfiles

Save your dotfiles in a repo

# Installation

Clone the repo, change the `*.sh` scripts to point to your repo, the run `dotfiles-install` and `dotfiles-setup`.

## ASDF fix

If using asdf, there's a bug in the `~/.asdf/plugins/maven/bin/exec-env` file, replace by this:

```
#!/usr/bin/env bash
# if asdf provides java, then let's use that rather the system one (if at all avail)
if asdf current java > /dev/null 2>&1 ; then
	asdf_java_version=$(asdf current java | sed -s 's|\(.*\)\s+\?(.*|\1|g')
	export JAVA_HOME=$(asdf where java $asdf_java_version)
fi
```
