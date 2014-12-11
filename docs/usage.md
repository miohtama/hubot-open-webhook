# Using webhooks

Hubot runs a HTTP server with routing where external services can make HTTP requets.

Open Webhook extends this HTTP server with various endpoint for accepting messages.

The communication is protected by signing the messages with a shared secret.
This protects against hostile parties sending chat messages to your chats.

First you need to configure the shared secret on your Hubot server.

## Security

Open Webhook HTTP endpoints are protected with shared secret password.
You need to configure your Hubot installation to read this

* Ansible installation: Edit `_hubot.env.j2` file and set `OPEN_WEBHOOK_SECRET` there.

* Manual installation: Export `OPEN_WEBHOOK_SECRET` environment variable in your Hubot startup script.

* Local development and testing - you can use default secret `insecure`:

# Testing webhooks

Start Hubot.

Then use [curl](http://curl.haxx.se/) command to send a test message:

    curl "http://127.0.0.1:8080/hubot/openwebhook/insecure/" --data-urlencode chat="mychatroom" --data-urlencode msg="My Message"

*My Message* should appear in the shell window where hubot is running.

For more information refer to `script/external-ping.sh` example script.

# Sending message from shell script

See example `external-ping.sh`.

# Sending message from Python

See example `external-ping.py`.

# Troubleshooting

## Restarting Hubot

If the hubot crashes you can go to the server and manually restart it. Example (from Ansible recipe):

    ssh myserv
    sudo service hubot restart

## Viewing log files

Example:

    tail -f /home/hubot/hubot/log/hubot.log

## Manually running Hubot in the terminal

    sudo su - hubot
    # Note that env file and -n switch change according to your hubot identity
    export HUBOT_LOG_LEVEL=debug
    cd /home/hubot/hubot && . /home/hubot/nvm/nvm.sh && nvm use 0.10.31 && source /home/hubot/hubot/sevabot.env && bin/hubot --adapter xmpp -n sevabot
