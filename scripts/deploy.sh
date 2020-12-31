#!/bin/bash

set -e

DATA_DATE=$(cat "../data/compile_date")
DATA_HASH=$(cat "../data/git_hash")
DATA_BRANCH=$(cat "../data/git_branch")

cd ../.temp

## Clear out the Directory

cd deploy

echo "# Compile Information" > README.md
echo "Commit hash: \`" $DATA_HASH "\`" >> README.md
echo "Commit Branch: \`" $DATA_BRANCH "\`" >> README.md
echo "Complie date: \`" $DATA_DATE "\`" >> README.md

COMMIT_MSG="Deployed Website on $DATA_DATE from $(hostname)"

git add .
git commit -m "$COMMIT_MSG"
git push