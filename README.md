sebastiaanschool
================

Repository for a Primary school app

## Building the iOS app

Building the app requires CocoaPods.

When looking into running this code yourself, you will need a Parse.com account. Enter you API details from Parse.com by copying the setEnv-example.sh to setEnv.sh and edit the resulting file with your own credentials.

After setting your credentials in the said setEnv.sh file, run all curl scripts in the cloudcode project.

Continous integration is available on Travis-CI: https://travis-ci.org/jeroenleenarts/sebastiaanschool/

## Building the Android app

You need to download the Parse.com Android library and put it into the `Android/Sebastiaanschool/libs/` directory.

Your Parse.com credentials are merged into the Android app by means of a `ParseConfig.java` generated alongside `BuildConfig.java`.

## Other notes

The cloudcode project contains a few hooks right now dealing with notifications. But those are not needed right now.

## Terms of use

"sebastiaanschool" is copyright Jeroen Leenarts, except for the Android app which is copyright Barend Garvelink. Both parts can be used in accordance with the Creative Commons Attribution-NonCommercial 3.0 Unported License.

You should have received a copy of the license along with this work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.


All brand names and icons are trademarks of their respective owners.
