#!/bin/bash

# This script builds the website

DATA_COW_PATH="../data/cow"
DATA_DATE="../data/compile_date"
DATA_HASH="../data/git_hash"
DATA_BRANCH="../data/git_branch"

## Generate the Cow
. motd.sh "Hello World" > $DATA_COW_PATH

## Add compile information
date > $DATA_DATE
git branch --no-color | grep "*" | sed 's/* //g' > $DATA_BRANCH
git rev-parse HEAD > $DATA_HASH

## Build website with Zola
cd ../

# Set output dir https://www.getzola.org/documentation/getting-started/cli-usage/
zola build