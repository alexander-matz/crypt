#!/bin/bash

run() {
  echo "$@"
  "$@"
}

if [[ $# -lt 2 ]]; then
  echo "usage: $0 encrypt|decrypt <filename>"
  exit 1
fi
mode=$1
filename="$2"

if [[ $mode == encrypt ]]; then
  if [[ "$filename" == *.asc ]]; then
    echo "input file must not be .asc"
    exit 1
  fi
  run gpg -c -a --cipher-algo AES256 "$filename"
  echo "please delete file $filename now"
elif [[ $mode == decrypt ]]; then
  if [[ "$filename" != *.asc ]]; then
    echo "input file must be .asc"
    exit 1
  fi
  output_file=${filename%.*}
  run gpg -o "$output_file" -d "$filename"
else
  echo "unknown command $mode"
  exit 1
fi
