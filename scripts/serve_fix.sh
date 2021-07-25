#!/bin/bash

# Serves the site for local development

cd ..

# zola serve &

# sleep 1

cd public

rm -rf node_modules

ln -s ../node_modules

cd ..
