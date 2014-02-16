#!/bin/bash
# SebastiaanSchool (c) 2014 by Jeroen Leenarts
#
# SebastiaanSchool is licensed under a
# Creative Commons Attribution-NonCommercial 3.0 Unported License.
#
# You should have received a copy of the license along with this
# work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

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
            	"publishedAt":{"__type": "Date", "iso": "2013-01-01T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?16056",
            	"name":"januari 2013"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-12-15T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?15857",
				"name":"december 2012"
			}
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-12-05T00:00:00.000Z"},
        	    "url":"http://www.sebastiaanschool.nl/sf.mcgi?15805",
            	"name":"Sinterklaas nieuwsbrief 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-11-05T00:00:00.000Z"},
   	    	    "url":"http://www.sebastiaanschool.nl/sf.mcgi?15692",
    	        "name":"november 2012"
    	    }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-10-05T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?15337",
            	"name":"oktober 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-08-05T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?15072",
				"name":"augustus/september 2012"
			}
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-06-05T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14936",
            	"name":"juni 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-05-05T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14744",
            	"name":"mei 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-04-15T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14536",
            	"name":"Playbackshow juni 2012 aanmelding"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-04-05T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14535",
            	"name":"april 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-03-15T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14165",
            	"name":"Seb@stiaan goes English!!"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-03-05T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14333",
            	"name":"maart 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-02-05T00:00:00.000Z"},
            	"url":"http://www.sebastiaanschool.nl/sf.mcgi?14207",
            	"name":"februari 2012"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/NewsLetter",
            "body": {
            	"publishedAt":{"__type": "Date", "iso": "2012-01-05T00:00:00.000Z"},
				"url":"http://www.sebastiaanschool.nl/sf.mcgi?14108",
				"name":"januari 2012"
			}
		}
	]
}' \
https://api.parse.com/1/batch

echo ""

