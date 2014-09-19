#!/bin/sh
#
# Example shell script for sending a message to Hubot.
#

chatroom="My chat id"
msg="Hello Hubot"
secret="insecure"

# We are using 127.0.0.1 as localhost doesn't work on OSX
# (IPv6 issue?)
msgaddress="http://127.0.0.1:8080/hubot/openwebhook/$secret/"

curl $msgaddress --data-urlencode chat="$chatroom" --data-urlencode msg="$msg"
