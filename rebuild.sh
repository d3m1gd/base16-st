#!/bin/sh

st_dir="$proj/st"
base_16_dir="$proj/base16-st"
schemes="$proj/base16-builder/schemes"
target_file="$st_dir/config.def.h"

cnt=1

for file in "$schemes"/*.yml; do
  [ -f "$file" ] || continue

  light="$(basename "${file%.yml}.light.patch")"
  dark="$(basename "${file%.yml}.dark.patch")"
  
  ./stpatches.sh "$file" light > /tmp/l
  ./stpatches.sh "$file" dark > /tmp/d

  sed -i -e '/Terminal colors/r /tmp/d' -e '/colorname\[\]/,/^};/d' "$target_file"
  ( cd "$st_dir" &&
    git diff > "$base_16_dir"/"$dark" &&
    git checkout "$target_file"
  )

  sed -i -e '/Terminal colors/r /tmp/l' -e '/colorname\[\]/,/^};/d' "$target_file"
  sed -i -e '/defaultfg =/s/7/256/' -e '/defaultbg =/s/0/257/' "$target_file"
  ( cd "$st_dir" &&
    git diff > "$base_16_dir"/"$light" &&
    git checkout "$target_file"
  )

  echo $cnt: $file
  cnt=$(( cnt + 1 ))
done
