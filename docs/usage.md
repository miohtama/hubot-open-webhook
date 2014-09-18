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

Then use `curl` to send a test message with `send.sh` test script. Edit the script if necessary:

    script/external-ping.sh

The script refers to chat id, but this is only valid for non-shell Hubot chat sessions.


