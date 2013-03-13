#!/bin/bash

source ../config/setCloudEnv.sh

curl -X POST \
  -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
  -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
        "name": "staff",
        "ACL": {
          "*": {
            "read": true
          }
        }
      }' \
  https://api.parse.com/1/roles
