#!/bin/bash

set -e

# This script builds the website

DATA_COW_PATH="../data/cow"
DATA_DATE="../data/compile_date"
DATA_HASH="../data/git_hash"
DATA_BRANCH="../data/git_branch"

## Generate the Cow
. motd.sh "I mount my soul at /dev/null" > $DATA_COW_PATH

## Add compile information
date > $DATA_DATE
git branch --no-color | grep "*" | sed 's/* //g' > $DATA_BRANCH
git rev-parse HEAD > $DATA_HASH

cd ../

## Copy in external data

cd static/


cp -r ../.temp/extern extern
pwd

cd ../

## Pull the latest version of the deployed website

cd .temp/deploy

git pull

cd ../../

pwd

## Build website with Zola

# Set output dir https://www.getzola.org/documentation/getting-started/cli-usage/
zola build --output-dir .temp/deploy/public

# Fix the node modules
cd .temp/deploy

rm -rf node_modules
cp -r ../../node_modules ./node_modules

## Clean up

rm -rf static/extern

echo "Website is ready for deployment"