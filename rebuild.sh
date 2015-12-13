#!/bin/sh

st_dir="$proj/st"
base_16_dir="$proj/base16-st"
schemes="$proj/base16-builder/schemes"

cnt=1

for file in "$schemes"/*.yml; do
  [ -f "$file" ] || continue

  light="$(basename "${file%.yml}.light.patch")"
  dark="$(basename "${file%.yml}.dark.patch")"
  
  ./stpatches.sh "$file" light > /tmp/l
  ./stpatches.sh "$file" dark > /tmp/d

  sed -i -e '/Terminal colors/r /tmp/d' -e '/colorname\[\]/,/^};/d' "$st_dir"/config.def.h
  ( cd "$st_dir" &&
    git diff > "$base_16_dir"/"$dark" &&
    git checkout "$st_dir"/config.def.h
  )

  sed -i -e '/Terminal colors/r /tmp/l' -e '/colorname\[\]/,/^};/d' "$st_dir"/config.def.h
  ( cd "$st_dir" &&
    git diff > "$base_16_dir"/"$light" &&
    git checkout "$st_dir"/config.def.h
  )

  echo $cnt: $file
  cnt=$(( cnt + 1 ))
done
