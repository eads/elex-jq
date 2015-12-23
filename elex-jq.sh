#!/bin/bash

mkdir -p .cache

if [ ! -f '.cache/2015-11-03.json' ]; then
  printf "getting 2015-11-03"
  elex results 2015-11-03 --debug -o json > .cache/2015-11-03.json
fi

if [ ! -f '.cache/2016-02-01.json' ]; then
  printf "getting 2016-02-01"
  elex results 2016-02-01 --debug -o json > .cache/2016-02-01.json
fi

if [ ! -f '.cache/2016-02-09.json' ]; then
  printf "getting 2016-02-09"
  elex results 2016-02-09 --debug -o json > .cache/2016-02-09.json
fi

printf "BASIC IDENTITY"
printf "\n==============\n"
for f in .cache/*; do
  printf "\n-- $f:\n"
  cat $f | jq '[.[] | {id: .id, level: .level, statepostal: .statepostal, last: .last}][0:3]'
done

printf "\nNULL LEVELS"
printf "\n===========\n"
for f in .cache/*; do
  printf "\n-- $f:\n"
  cat $f | jq '[.[] | select(.level == null) | {id: .id, level: .level, statepostal: .statepostal, last: .last}][0:3]'
done

printf "\nNULL STATEPOSTALS"
printf "\n=================\n"
for f in .cache/*; do
  printf "\n-- $f:\n"
  cat $f | jq '[.[] | select(.statepostal == null) | {id: .id, level: .level, statepostal: .statepostal, last: .last}][0:3]'
done
