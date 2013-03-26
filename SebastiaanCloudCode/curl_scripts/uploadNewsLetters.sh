#!/bin/bash

source ../config/setCloudEnv.sh $1

curl -X POST \
  -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
  -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
        "requests": [
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?16056",
            	"name":"januari 2013"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?15857",
				"name":"december 2012"
			}
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
        	    "url":"http://www.sebastiaanschool.nl/sf.mcgi?15805",
            	"name":"Sinterklaas nieuwsbrief 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
   	    	    "url":"http://www.sebastiaanschool.nl/sf.mcgi?15692",
    	        "name":"november 2012"
    	    }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?15337",
            	"name":"oktober 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?15072",
				"name":"augustus/september 2012"
			}
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14936",
            	"name":"juni 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14744",
            	"name":"mei 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14536",
            	"name":"Playbackshow juni 2012 aanmelding"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14535",
            	"name":"april 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14165",
            	"name":"Seb@stiaan goes English!!"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14333",
            	"name":"maart 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14207",
            	"name":"februari 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
				"url":"http://www.sebastiaanschool.nl/sf.mcgi?14108",
				"name":"januari 2012"
			}
		}
	]
}' \
https://api.parse.com/1/batch

echo ""

