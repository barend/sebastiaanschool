#!/bin/bash
# SebastiaanSchool (c) 2014 by Jeroen Leenarts
#
# SebastiaanSchool is licensed under a
# Creative Commons Attribution-NonCommercial 3.0 Unported License.
#
# You should have received a copy of the license along with this
# work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

source setCloudEnv.sh $1

sed -e "s/PARSE_APPLICATION_ID/${PARSE_APPLICATION_ID}/g" -e "s/PARSE_MASTER_KEY/${PARSE_MASTER_KEY}/g" global.json.template >global.json
