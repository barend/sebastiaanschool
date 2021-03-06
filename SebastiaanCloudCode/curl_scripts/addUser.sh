#!/bin/bash
# SebastiaanSchool (c) 2014 by Jeroen Leenarts
#
# SebastiaanSchool is licensed under a
# Creative Commons Attribution-NonCommercial 3.0 Unported License.
#
# You should have received a copy of the license along with this
# work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

source ../config/setCloudEnv.sh $3

USER_NAME="$1"
PASSWORD="$2"

function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop`
    echo ${temp##*|}
}
prop='objectId'

json=`curl -X GET \
  -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
  -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
  https://api.parse.com/1/roles/`

roleObjectId=`jsonval`

json=`curl -s -X POST \
  -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
  -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{"username":"'${USER_NAME}'","password":"'${PASSWORD}'"}' \
  https://api.parse.com/1/users`

userObjectId=`jsonval`

curl -X PUT \
  -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
  -H "X-Parse-Master-Key: ${PARSE_MASTER_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
        "users": {
          "__op": "AddRelation",
          "objects": [
            {
              "__type": "Pointer",
              "className": "_User",
              "objectId": "'${userObjectId}'"
            }
          ]
        }
      }' \
  https://api.parse.com/1/roles/${roleObjectId}

echo ""
