#!/bin/bash

set -e

DATA_DATE=$(cat "../data/compile_date")
DATA_HASH=$(cat "../data/git_hash")
DATA_BRANCH=$(cat "../data/git_branch")

cd ../.temp/deploy

echo "# Compile Information" > README.md
echo "https://github.com/mboleary/arsmachina.net" >> README.md
echo "" >> README.md
echo "Commit hash: \`" $DATA_HASH "\`" >> README.md
echo "" >> README.md
echo "Commit Branch: \`" $DATA_BRANCH "\`" >> README.md
echo "" >> README.md
echo "Complie date: \`" $DATA_DATE "\`" >> README.md
echo "" >> README.md

COMMIT_MSG="Website built on $DATA_DATE from $(hostname)"

git add .
git commit -m "$COMMIT_MSG"
git push