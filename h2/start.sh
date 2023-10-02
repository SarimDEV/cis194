#!/bin/bash

filename="$1"  # Assuming the filename is passed as the first argument

name="$(echo "$filename" | sed 's/\.hs$//')"

DIR="build"
if [ ! -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Init build director..."
  mkdir $DIR
fi

echo "Starting $name ..."

ghc -o build/$name -hidir build -odir build $filename
./build/$name
