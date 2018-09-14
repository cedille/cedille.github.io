#!/bin/bash

mkdir ./language-overview/
for i in ../cedille/language-overview/*; do
  fname="$(basename $i)"
  mkdir "language-overview/${fname}/"
  ( echo "# $fname";
    echo;
    echo '```';
    cat $i;
    echo '```'; ) > language-overview/${fname}/README.md
done

{ cat language-overview-prefix.md ;
  for i in language-overview/*.ced; do
    fname="$(basename $i)";
    printf ' * [%s](./%s)\n' "$fname" "$fname";
  done; } > language-overview/README.md
