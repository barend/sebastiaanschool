#!/bin/bash

source setCloudEnv.sh

sed -e "s/PARSE_APPLICATION_ID/${PARSE_APPLICATION_ID}/g" -e "s/PARSE_MASTER_KEY/${PARSE_MASTER_KEY}/g" global.json.template >global.json
