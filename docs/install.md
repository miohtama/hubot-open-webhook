# Installation

There are two ways to install Hubot with open web hooks

* Ansible automatized installation if your are doing clean install

* By hand (see the end of this chapter)

## Installanting Hubot with Open Webhooks on fresh server

For the server-side installation, Open Webhook Chat can be deployed using [Ansible automatization tool](http://www.ansible.com/home).
Ansible runs a playbook "script" over SSH connection and automatizes server set up. Only SSH / sudo credentials are needed on the server before running the script.

Benefits of Ansible

* Automatic setup OS package dependencies, OS configuration files

* Automatic install Hubot

* Configure Hubot with your credentials

* Make Hubot start on the server restart

Thus, start working on Open Webhook on your local computer to get it automatically set up to the server using your SSH account.

## Get copy of hubot-open-webhook

Do this using Git:

    git clone https://github.com/miohtama/hubot-open-webhook

## Install Ansible software and its dependencies

**Do this on your local computer, not on your server**. Ansible is a local tool which
then will connect to your server or virtual machine over SSH.

On Ubuntu / Debian make sure you have Python development packages. On OSX you should have these out of the box::

    sudo apt-get install python-dev python-virtualenv

Install Ansible using [Virtualenv](http://opensourcehacker.com/2012/09/16/recommended-way-for-sudo-free-installation-of-python-software-with-virtualenv/) (no sudo needed):

    cd hubot-open-webhook
    git submodule update --init  # This will download rest of Git dependencies
    cd ansible
    virtualenv ansible-venv  # virtualenv command may vary by your operating system
    source ansible-venv/bin/activate
    pip install ansible

Then create the local "servers inventory" file `ansible/hosts.ini`. This gives server and user information for Ansible where to go to install stuff. One line is enough, it contains your server nickname, IP address, what SSH user to use to connect the server, where to install Hubot and what is the UNIX user running Hubot process:

    myhubotserver ansible_ssh_host=192.168.1.999 ansible_ssh_user=myunixuser hubot_dir=/srv/hubot hubot_admin=hubot

`myunixuser` being the user which you can SSH in and has sudo access on the server.

[Read more About ansible hosts inventory file](http://docs.ansible.com/intro_inventory.html).

## Run Ansible and let it deploy Hubot and dependencies on your server

**It is recommend to use SSH keys instead of passwords in automation**.

**Using SSH Keys**: .. or easier if you are using [SSH public keys](http://opensourcehacker.com/2012/10/24/ssh-key-and-passwordless-login-basics-for-developers/):

    ssh-copy-id myunixuser@192.168.1.999
    ansible-playbook --inventory-file=hosts.ini --ask-sudo-pass playbook.yml

**Using SSH password**: Then run Ansible against your server. You can do this with passwords (if you first install [sshpass](http://sshpass.sourceforge.net/):

    ansible-playbook --inventory-file=hosts.ini --asks-sudo-pass --ask-pass playbook.yml

This should finally output:

[Read more about running Ansible playbook](http://docs.ansible.com/playbooks_intro.html).

### Testing it out

Try test it out. Start shell test chat with Hubot:

    ssh hubot@myhubotserver
    cd /home/hubot/hubot && . /home/hubot/nvm/nvm.sh && nvm use 0.10.31 && . hubot.env  # Load environment variables
    bin/hubot --adapter shell

Test ping:

    Hubot> hubot: ping
    Hubot> PONG

You should see in the chat:

    Hubot> Hello Hubot

## Choose chat adapter end rerun Ansible to finish the installation

Choose any of chat adapter (see README for instructions) and set up a Hubot chat username and password.

Update `hosts.ini` to have your new chat backend adapter id.

Update `_hubot.env.j2` file to contain a secret which you need to share with external services sending in messages. This file should contain

* Chat backend specific configuration entries (username, password to chat)

* The shared secret which you use to secure the webhook

* IP address and port Hubot is set listening to for HTTP

Example `_hubot.env.j2` for XMPP chat:

    export OPEN_WEBHOOK_SECRET="verysecret"
    export HUBOT_XMPP_USERNAME="hubot@chat.example.com"
    export HUBOT_XMPP_PASSWORD="xmpppass"
    export HUBOT_XMPP_ROOMS="hubot-alerts@conference.chat.example.com"

    # Public IP
    export BIND_ADDRESS="1.1.1.1"

    # Port Hubot is listening to for incoming chat messages
    export PORT="8080"

Edit the files locally, then rerun Ansible playbook.

## Test sending external message

Test sending external message (from your local computer):

    curl "http://192.168.1.999:8080/hubot/openwebhook/insecure/" --data-urlencode chat="testchatroom" --data-urlencode msg="Hello Hubot"

## Securing open web hooks with HTTPS

You can set up HTTPS web server, like Nginx or Apache, at the front of Hubot to secure your chat traffic.
The web server decodes SSL and then proxies the incoming requests to Hubot.

## Troubleshooting

For the debugging the server you can manually connect there and try to run hubot
from the command line.

    ssh hubotuser@myserver
    cd hubot
    pkill -f hubot  # Kill all existing hubos

    . /home/hubot/nvm/nvm.sh
    nvm use 0.10.31
    . hubot.env  # Load environment variables

    # For shel testing
    export HUBOT_LOG_LEVEL="debug"
    bin/hubot --adapter shell

    # For XMPP
    # bin/hubot --adapter xmpp # Start hubot, this will print any errors hubot has on the startup

## Installing Open Webhooks on existing Hubot

This is for you if you have Hubot already running on a server or you
don't want to install Hubot using ansible.

[Install Hubot](https://github.com/github/hubot/blob/master/docs/deploying/unix.md)

Install Open Webhook NPM package inside your Hubot installation::

    npm install hubot-open-webhook

Enable Open Webhook in Hubot. Edit `myhubot/external-scripts.json` and add it as external script:

    [..., "hubot-open-webhook"]

Edit the Hubot script which gives it its environment variables.

Restart Hubot.




