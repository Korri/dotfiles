#!/bin/zsh
set -e

git config --global user.email "$SPIN_USER_EMAIL"

extension=$(while read file; do echo $(git log --pretty=format:%ad -n 1 --date=raw -- $file) $file; done < <(ls dev-test-runner/*.vsix) | sort -k1,1n | tail -n 1 | cut -d " " -f3)
code --install-extension $extension