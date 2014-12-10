# Using webhooks

Hubot runs a HTTP server with routing where external services can make HTTP requets.

Open Webhook extends this HTTP server with various endpoint for accepting messages.

The communication is protected by signing the messages with a shared secret.
This protects against hostile parties sending chat messages to your chats.

First you need to configure the shared secret on your Hubot server.

## Using Ansible

- If you are using Ansible you can put this to `hosts.ini` file

## Using custom Hubot installation

Export `OPEN_WEBHOOK_SECRET` environment variable in your Hubot startup script.

## Local development

Export `OPEN_WEBHOOK_SECRET` before running Hubot.

    export OPEN_WEBHOOK_SECRET="xxx"
    bin/hubot

# Testing webhooks

Start Hubot.

Then use `curl` to send a test message

    curl "http://127.0.0.1:8080/hubot/openwebhook/insecure/" --data-urlencode chat="mychatroom" --data-urlencode msg="My Message"

*My Message* should appear in the shell window where hubot is running.

For more information refer to `script/external-ping.sh` example script.



