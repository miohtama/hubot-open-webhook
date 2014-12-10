# Using Hubot with XMPP

[hubot-xmpp adapter](https://github.com/markstory/hubot-xmpp) is used.
It is installed with Ansible playbook.

## Setting up XMPP client connection

### Setting up XMPP credentials with Ansible

[First see Ansible installation instructions](./install.md).

You need to have registered an XMPP account. If you have not used
XMPP before you can use a public XMPP server like [jabber.at](jabber.at)
and register two test accounts and make a chat room. Please see *Testing
XMPP chat* below.

Edit `_hubot.env.j2` and export connection details for `hubot-xmpp` using environment variables:

    # The nick must contain host part
    export HUBOT_XMPP_USERNAME="hubo@jabber.at"
    export HUBOT_XMPP_PASSWORD="x"
    # All chat room references must be absolute
    export HUBOT_XMPP_ROOMS="hubohubo@conference.jabber.at"

Rerun `ansible-playbook`. Hubot on the server will restart and try to reconnect to
XMPP.

See troubleshooting section in installation documentation how clear any problems.

### Setting credentials by hand

This is for those who install and maintain hubot by hand.

Example:

    npm install hubot-xmpp

    export HUBOT_XMPP_USERNAME="hubo@jabber.at"
    export HUBOT_XMPP_PASSWORD="x"
    export HUBOT_XMPP_ROOMS="hubohubo@conference.jabber.at"
    export HUBOT_LOG_LEVEL="debug"
    # You need to give explicit name as Hubot don't know its own XMPP name
    bin/hubot --adapter xmpp -n hubo

## Testing XMPP chat

### Sending external test message

Make Hubot open webhooks to reply you (use bot name given with `-n`:

    hubo: sad

    19:53:19 - mikko: sevabot: xmpp
    19:53:20 - sevabot: Hey mikko! You told me in XMPP room sevabot@conference.chat.example.com to talk to you.

Then you can try with open webhook message:

    curl "http://127.0.0.1:8080/hubot/openwebhook/insecure/" --data-urlencode chat="mychatroom@conference.chat.example.com" --data-urlencode msg="Hello world"

.. sends a messge *Hello world* to chat room *mychatroom*.

Note that XMPP is picky with chat room domain. The real DNS entry does not need to exist though.

### XMPP client software

[Profanity command-line based XMPP client](http://www.profanity.im/) is recommended for XMPP testing sas it is very verbose with errors.

Connect to the server:

    /connect example@jabbet.at

Join to the chat room:

    /join hubottestroom

Start Hubot and XMPP.

See the bot connect.

