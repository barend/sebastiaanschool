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
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-02-18T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-02-22T00:00:00.000Z"},
            	"name":"Krokusvakantie",
                "type":"V"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-03-29T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-03-29T00:00:00.000Z"},
                "name":"Goede Vrijdag",
                "type":"V"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-04-01T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-04-01T00:00:00.000Z"},
                "name":"Paasmaandag",
                "type":"V"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-04-29T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-05-10T00:00:00.000Z"},
                "name":"Tulpvakantie",
                "type":"V"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-05-20T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-05-20T00:00:00.000Z"},
                "name":"Pinkstermaandag",
                "type":"V"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-07-22T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-08-30T00:00:00.000Z"},
                "name":"Zomervakantie",
                "type":"V"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-02-01T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-02-01T00:00:00.000Z"},
                "name":"Studiedag",
                "type":"T"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-04-10T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-04-10T00:00:00.000Z"},
                "name":"Studiedag",
                "type":"T"
            }
        },
        {
            "method": "POST",
            "path": "/1/classes/AgendaItem",
            "body": {
                "start":{"__type": "Date", "iso": "2013-06-10T00:00:00.000Z"},
                "end":{"__type": "Date", "iso": "2013-06-10T00:00:00.000Z"},
                "name":"Studiedag",
                "type":"T"
            }
        }
	]
}' \
https://api.parse.com/1/batch

echo ""

