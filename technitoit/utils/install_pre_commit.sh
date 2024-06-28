#!/usr/bin/env bash

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing pre-commit..."
# this command creates symlink to our pre-commit script
ln -s ../../utils/pre-commit $GIT_DIR/hooks/pre-commit
echo "Done!" 