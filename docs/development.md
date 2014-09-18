# Development

## Setting up development environment

To install Hubot in for development you can do a local NPM package installation:

    mkdir myproject
    cd myproject
    npm install hubot coffee-script
    export PATH=$PATH:node_modules/.bin
    hubot --create myhubot

Now you have folder structure:

    hubot-open-webhook
    hubot-open-webhook/myhubot

Then you can start Hubot in shell chat mode - you can only chat with hubot from terminal
and it is not connected to any chat network:

    cd myhubot
    bin/hubot

Then check that Hubot is responding:

    hubot: ping

Close down hubot with `CTRL + D`.

Now enable Open Webhook in Hubot. Edit `myhubot/external-scripts.json` and set it as:

    ["hubot-open-webhook"]

In myhubot folder install ``hubot-open-webhook``:

    ln .. node_modules/hubot-open-webhook

Restart hubot::

    bin/hubot

Check that now Open Webhooks scripts responds:

    hubot: sad

Hubot should reply and comfort you on your journey to the grey programming world:

    Hubot> hubot: sad
    Hubot> Shell: Hubot loves Shell

## Running tests

To run unit tests:

    bin/test
