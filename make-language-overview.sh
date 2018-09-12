#!/bin/bash

for i in ../cedille/language-overview/*; do
  fname="$(basename $i)"
  ( echo "# $fname";
    echo;
    echo '```';
    cat $i;
    echo '```'; ) > language-overview/${fname}.md;
done

{ cat language-overview-prefix.md ;
  for i in language-overview/*; do
    fname="$(basename $i)";
    printf ' * [%s](./%s)\n' "$fname" "$i";
  done; } > language-overview/language-overview.md
