
Open-webhook-chat is a [Hubot](https://hubot.github.com/) script allowing you
to send chat notifications from any server software easily. It is useful for software development
workflow automatization and server monitoring.

* Support sending chat messages from shell scripting or any programming language

* Push chat messages using HTTP/HTTPS requsts

* Good documentation how to set up this, so you can get it working even with the most junior sysadmin skills

# Supported chat networks and applications

Hubot is a chat bot maintained by Github and written in CoffeeScript / NodeJS.
It supports [multiple chat networks](https://github.com/github/hubot/blob/master/docs/adapters.md), including XMPP,
GTalk and IRC.

# Dependencies

* NodeJS

* NPM

# Features and history

This project aims to reimplement ato implement Sevabot, the friendly Skype bot, functionality in Hubot.
Sevabot served well as an extensible Skype bot. However, Microsoft started to shutdown Skype APIs for third parties, so one no longer can effectively run and maintain Skype chat bots with the guarantee they work tomorrow.

Meanwhile, Hubot project had grown popular. Thus, it was time to bury Sevabot and migrate the innovation
born in Sevabot project to another open ecosystem.

Open webhook chat is the rewrite of Sevabot, to  bring some aspects of Sevabot to Hubot

* Open-ended webhooks - send chat messages and notifications from any shell script or server-side application.
  This is the killer feature, as you could easily get a notification e.g. when your cron scripts failed.

* Out of the box support for

    - Subversion

    - Github

    - Plone error log

# Installation

## Installanting Hubot with Open Webhooks on fresh server

For the server-side installation, Open Webhook Chat can be deployed using [Ansible automatization tool](http://www.ansible.com/home).
Ansible run a playbook over SSH connection and automatizes server set up. Only SSH / sudo credentials are needed.

We use [Ansible Hubot](https://github.com/miohtama/ansible-hubot) role. Ubuntu and Debian servers supported.

## Get copy of hubot-open-webhook

Do this using Git:

    git clone git@github.com:miohtama/hubot-open-webhook.git

### Local dependencies

You need to install Ansible locally on your own computer first.

On Ubuntu make sure you have Python requirements::

    sudo apt-get install python-dev python-virtualenv

Install Ansible using Virtualenv (no sudo needed):

    cd hubot-open-webhook
    cd ansible
    virtualenv ansible-venv
    source ansible-venv/bin/activate
    pip install ansible

Create a inventory file `ansible/hosts.ini` - here you will put your server information.
One line is enough:

    myhubotserver ansible_ssh_host=999.999.999.999 ansible_ssh_user=myunixusername

### Run Ansible and let it install Hubot and dependencies

**It is recommend to use SSH keys instead of passwords in automation**.

Then run Ansible against your server. You can do this with passwords (if you first install [sshpass](http://sshpass.sourceforge.net/):

    ansible-playbook --inventory-file=hosts.ini --asks-sudo-pass --ask-pass playbook.yml

.. or easier if you are using [SSH public keys](http://opensourcehacker.com/2012/10/24/ssh-key-and-passwordless-login-basics-for-developers/):

    ssh-copy-id myunixuser@999.999.999.999
    ansible-playbook --inventory-file=hosts.ini --asks-sudo-pass playbook.yml

This will

* Setup OS package dependencies

* Install Hubot

* Configure Hubot with your credentials

### Configuring Hubot with Ansible

XXX

## Installing Open Webhooks on existing Hubot

XXX

## Chat backends

XXX

### Using with GTalk

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

In myhubot folder install ``hubot-open-webhook``::

    npm install ..

Restart hubot::

    bin/hubot

Check that now Open Webhooks scripts responds::

    hubot: sad

Hubot should reply and confort you on your journey to the grey programmign world.

## Running tests

To run unit tests:

    bin/test






