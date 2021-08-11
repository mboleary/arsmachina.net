#!/bin/bash

# Pre-build script that downloads and copies over assets from other sources, such as NPM, or other git repos

cd ../

## Import Fractals-canvas demo

cd .temp

mkdir -p extern

cd extern

git clone https://github.com/mboleary/fractals-canvas.git

cd fractals-canvas

rm -rf .git