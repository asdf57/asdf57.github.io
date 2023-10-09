#!/bin/bash

[[ -f archive.tar ]] && rm archive.tar
[[ -f archive.enc ]] && rm archive.enc

tar -cvzf archive.tar --exclude='.git' --exclude passfile .
openssl enc -aes-256-cbc -pbkdf2 -salt -in archive.tar -out archive.enc -pass file:passfile

git add -A

git commit -m "Update website at `date --iso-8601=seconds`"

git push
