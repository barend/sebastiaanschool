#!/bin/bash
# SebastiaanSchool (c) 2014 by Jeroen Leenarts
#
# SebastiaanSchool is licensed under a
# Creative Commons Attribution-NonCommercial 3.0 Unported License.
#
# You should have received a copy of the license along with this
# work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

source ../../iOS/SebastiaanSchool/bin/setEnv.sh

sed -e "s/DEV_PARSE_APPLICATION_ID/${DEV_PARSE_APPLICATION_ID}/g" -e "s/DEV_PARSE_MASTER_KEY/${DEV_PARSE_MASTER_KEY}/g" -e "s/PARSE_APPLICATION_ID/${PARSE_APPLICATION_ID}/g" -e "s/PARSE_MASTER_KEY/${PARSE_MASTER_KEY}/g" global.json.template >global.json
