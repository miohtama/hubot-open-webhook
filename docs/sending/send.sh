#!/bin/sh
#
# Example shell script for sending a message into sevabot
#
# Give command line parameters [chat id] and [message].
# The message is md5 signed with a shared secret specified in settings.py
# Then we use curl do to the request to sevabot HTTP interface.
#
#

chat="My chat title"
msg="Hello Hubot"
secret="xxx"
msgaddress="http://localhost:8080/openwebhook/md5signed/"

md5=`echo -n "$chat$msg$secret" | md5sum`

#md5sum prints a '-' to the end. Let's get rid of that.
for m in $md5; do
    break
done

curl $msgaddress --data-urlencode chat="$chat" --data-urlencode msg="$msg" --data-urlencode md5="$m"
