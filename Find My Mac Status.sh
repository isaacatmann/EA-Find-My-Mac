#!/bin/bash

# Purpose: to see if machine is enrolled in Find My Mac

loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`
homedir=$(dscl . -read /Users/$loggedInUser NFSHomeDirectory | cut -d' ' -f2)

FindMyMac=$(/usr/libexec/PlistBuddy -c "print :Accounts:0:Services" "$homedir"/Library/Preferences/MobileMeAccounts.plist | grep -B 1 FIND_MY_MAC | grep Enabled | awk '{print $3}')

echo "<result>$FindMyMac</result>"