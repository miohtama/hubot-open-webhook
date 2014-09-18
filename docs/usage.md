# Using webhooks

Hubot runs a HTTP server with routing where external services can make HTTP requets.

Open Webhook extends this HTTP server with various endpoint for accepting messages.

The communication is protected by signing the messages with a shared secret.

First you need to configure the shared secret on your Hubot server.

## Using Ansible

- If you are using Ansible you can put this to `hosts.ini` file

-

## Using custom Hubot installation

Export `OPEN_WEBHOOK_SECRET` environment variable in your Hubot startup script.