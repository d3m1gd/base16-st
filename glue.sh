#!/bin/sh

st_dir="$proj/st"
base_16_dir="$proj/base16-st"

all=$#
cnt=1

for file; do
  [ -f "$file" ] || continue

  patchfile="$(basename "${file%xresources}patch")"
  
  ./stpatches.sh "$file" >> "$st_dir"/config.def.h
  kak -e "exec $(cat script.kak)" "$st_dir"/config.def.h
  ( cd "$st_dir" &&
    git diff > "$base_16_dir"/"$patchfile" &&
    git checkout "$st_dir"/config.def.h )

  echo $cnt of $all done
  cnt=$(( cnt + 1 ))
done
