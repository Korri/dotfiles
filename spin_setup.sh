#!/bin/zsh
set -xe

echo "Running SPIN specific setup..."

echo "Adding email to git local config"
echo '[user]
	email = hugo.vacher@shopify.com
' >> ~/.gitconfig_local