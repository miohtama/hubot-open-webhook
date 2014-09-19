#!/bin/sh
#
# Example shell script for sending a message to Hubot.
#

chatroom="My chat id"
msg="Hello Hubot"
secret="xxx"

# We are using 127.0.0.1 as localhost doesn't work on OSX
# (IPv6 issue?)
msgaddress="http://127.0.0.1:8080/hubot/openwebhook/signed/md5/"

md5=`echo -n "$chatroom$msg$secret" | md5sum`

# md5sum prints a '-' to the end. Let's get rid of that.
# no string  stripping in shell...
for m in $md5; do
    break
done

curl $msgaddress --data-urlencode chat="$chatroom" --data-urlencode msg="$msg" --data-urlencode md5="$m"
