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

Useful for local testing.

Example:

    npm install hubot-xmpp

    export HUBOT_XMPP_USERNAME="hubo@jabber.at"
    export HUBOT_XMPP_PASSWORD="x"
    export HUBOT_XMPP_ROOMS="hubohubo@conference.jabber.at"
    export HUBOT_LOG_LEVEL="debug"
    bin/hubot --adapter xmpp

## Testing XMPP chat

Use [Profanity command-line based XMPP client](http://www.profanity.im/).

Connect to the server:

    /connect example@jabbet.at

Join to the chat room:

    /join hubottestroom

Start Hubot and XMPP.

See the bot connect.

