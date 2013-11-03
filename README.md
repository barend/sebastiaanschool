sebastiaanschool
================

Repository for a Primary school app

## Building the iOS app

When looking into running this code yourself, you will need a Parse.com account. Enter you API details from Parse.com by copying the setEnv-example.sh to setEnv.sh and edit the resulting file with your own credentials.

After setting your credentials in the said setEnv.sh file, run all curl scripts in the cloudcode project.

## Building the Android app

The setEnv.sh covers the Parse.com credentials for cloudcode and iOS. To get your Parse.com credentials into the Android app, you need to edit the `SebApp.java` file in the `parse` product flavor (for the time being). In addition, you need to download the Parse.com Android library and put it into the `libs/` directory.

## Other notes

The cloudcode project contains a few hooks right now dealing with notifications. But those are not needed right now.

Building the app requires CocoaPods.

"sebastiaanschool" is licensed under the MIT license. See LICENCE file for details.
