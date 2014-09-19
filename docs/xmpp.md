# Using Hubot with XMPP

[hubot-xmpp adapter](https://github.com/markstory/hubot-xmpp) is needed.

## Setting up XMPP client connection

### Setting up XMPP credentials with Ansible

Edit `_hubot.env.j2` and export connection details for `hubot-xmpp` using environment variables:

    export HUBOT_XMPP_USERNAME="hubo@jabber.at"
    export HUBOT_XMPP_PASSWORD="x"
    export HUBOT_XMPP_ROOMS="hubohubo@conference.jabber.at"

Rerun `ansible-playbook`. Hubot on the server will restart and try to reconnect to
XMPP.

For the debugging the server you can manually connect there and try to run hubot
from the command line.

    ssh hubotuser@myserver
    cd hubot
    pkill -f hubot  # Kill all existing hubos

    . /home/hubotuser/nvm/nvm.sh
    nvm use 0.10.31
    . hubot.env  # Load environment variables
    bin/hubot --adapter xmpp # Start hubot

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

## Setting up XMPP test server

Use [Prosody](http://prosody.im/download/start).

On OSX:

    brew install http://prosody.im/files/homebrew/luasec.rb &&
    brew install http://prosody.im/files/homebrew/luaevent.rb &&
    brew install https://prosody.im/files/homebrew/prosody.rb

    etc....




