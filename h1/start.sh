#!/bin/sh

echo "Starting..."
ghc -o build/validate-credit-card-numbers -hidir build -odir build validate-credit-card-numbers.hs
./build/validate-credit-card-numbers
