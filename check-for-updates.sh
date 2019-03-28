#!/bin/bash

cedille_dir="../cedille"
last_release="release-1.1"

echo "checking $cedille_dir for differences"

branch=$(cd "$cedille_dir" && git rev-parse --abbrev-ref HEAD)
if [ "$branch" != "$last_release" ]; then
  echo "the release branch \"$last_release\" is not checked out in the repo $cedille_dir"
  exit
fi

OLDIFS=$IFS; IFS=','
for i in BUILD.md,BUILD.md\
         semantics.pdf,docs/semantics/paper.pdf; do
  set -- $i
  diff -q "$1" "$cedille_dir/$2"
done
IFS=$OLDIFS

OLDIFS=$IFS; IFS=','
for i in docs,docs/html\
         info,docs/info; do
  set -- $i
  diff -rq "$1/" "$cedille_dir/$2/"
done
IFS=$OLDIFS
