# Using Hubot with GTalk

[hubot-gtalk adapter](https://github.com/atmos/hubot-gtalk) is used.
It is installed with Hubot Open Webhook Ansible playbook.

[Hubot does not support group chats in GTalk](https://github.com/atmos/hubot-gtalk/issues/30).

Register a dummy gmail account or create a user in Google Apps for Work.

## Setting environment variables

Example `_hubot.env.j2` for Ansible:

    export OPEN_WEBHOOK_SECRET="verysecret"

    # https://github.com/atmos/hubot-gtalk
    export HUBOT_GTALK_USERNAME="hubot@example.com"
    export HUBOT_GTALK_PASSWORD="password"
    export HUBOT_GTALK_WHITELIST_DOMAINS="example.com,gmail.com"

Example `hosts.ini`:

    hubotserv ansible_ssh_user=root hubot_dir=/home/hubot/hubot hubot_admin=hubot hubot_adapter=gtalk

## Connectiong to Hubot

Invite hubot to GMail Talk with full email. E.g. `hubot@example.com`.

    git+https://git@github.com/xslim/hubot-gtalk.git