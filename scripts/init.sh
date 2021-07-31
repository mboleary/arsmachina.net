#!/bin/bash

# This script initializes the build environment

cd ..

# Remove Existing temp directory
rm -rf .temp

mkdir -p data
mkdir .temp

# Clone deploy repo
cd .temp

git clone git@gitlab.com:mboleary/mboleary.gitlab.io.git deploy


# extern is used for external content that is brought into the final build
mkdir -p extern
