#!/bin/bash

echo "Setting up local repo with remote origin"

echo ">>> Verifying git config"
git config --global --list

echo ">>> Verifying git global gitignore"
cat ~/.gitignore_global

echo "You need to have a local repo with git init/commit done first"

read -p "Enter your remote URL: " remote_url
git remote add origin $remote_url

git pull --rebase origin main

read -p "Want to proceed with push to origin main? (y/n) " proceed

if [ "$proceed" != "y" ]; then
    git push -u origin main
else
    echo "Done with pushing to remote"
fi