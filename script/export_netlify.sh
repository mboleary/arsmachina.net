#!/bin/bash

## Uploads site to netlify

set -a

source .env

DEPLOY_FILE=$1

echo $ACCESS_TOKEN

curl -H "Content-Type: application/zip" \
     -H "Authorization: Bearer $ACCESS_TOKEN" \
     --data-binary "$DEPLOY_FILE" \
     https://api.netlify.com/api/v1/sites/$SITE_ID/deploys
