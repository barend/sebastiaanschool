#!/bin/bash
# SebastiaanSchool (c) 2014 by Jeroen Leenarts
#
# SebastiaanSchool is licensed under a
# Creative Commons Attribution-NonCommercial 3.0 Unported License.
#
# You should have received a copy of the license along with this
# work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

source ../../iOS/SebastiaanSchool/bin/setEnv.sh

if [ "$1" = 'PROD' ];
then
	PARSE_APPLICATION_ID=${PARSE_APPLICATION_ID}
	PARSE_MASTER_KEY=${PARSE_MASTER_KEY}
	PARSE_REST_API_KEY=${PARSE_REST_API_KEY}
elif [ "$1" = 'DEV' ];
then
	PARSE_APPLICATION_ID=${DEV_PARSE_APPLICATION_ID}
	PARSE_MASTER_KEY=${DEV_PARSE_MASTER_KEY}
	PARSE_REST_API_KEY=${DEV_PARSE_REST_API_KEY}
else
	echo "Unknown option."
	exit 1
fi
