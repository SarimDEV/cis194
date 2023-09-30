#!/bin/bash

filename="$1"  # Assuming the filename is passed as the first argument

name="$(echo "$filename" | sed 's/\.hs$//')"

echo "Starting $name ..."

ghc -o build/$name -hidir build -odir build $filename
./build/$name
