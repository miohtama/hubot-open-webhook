# Installation

## Installanting Hubot with Open Webhooks on fresh server

For the server-side installation, Open Webhook Chat can be deployed using [Ansible automatization tool](http://www.ansible.com/home).
Ansible run a playbook over SSH connection and automatizes server set up. Only SSH / sudo credentials are needed.

We use [Ansible Hubot](https://github.com/miohtama/ansible-hubot) role. Ubuntu and Debian servers supported.

**Do this on your local computer, not on your server**. Ansible is a local tool which
then will connect to your server or virtual machine over SSH.

## Get copy of hubot-open-webhook

Do this using Git:

    git clone https://github.com/miohtama/hubot-open-webhook

### Local dependencies

You need to install Ansible locally on your own computer first.

On Ubuntu / Debian make sure you have Python development packages. On OSX these should be out of the box::

    sudo apt-get install python-dev python-virtualenv

Install Ansible using Virtualenv (no sudo needed):

    cd hubot-open-webhook
    git submodule update  # This will download rest of Git dependencies
    cd ansible
    virtualenv ansible-venv
    source ansible-venv/bin/activate
    pip install ansible

Create a inventory file `ansible/hosts.ini` - here you will put your server information.
One line is enough, it contains your server nickname, IP address, what SSH user to use to connect the server,
where to install Hubot and what is the UNIX user running Hubot process:

    myhubotserver ansible_ssh_host=192.168.1.999 ansible_ssh_user=myunixuser hubot_dir=/home/myunixuser/hubot hubot_admin=myunixuser

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

* Make Hubot start on the server restart

### Configuring Hubot to use Pidgit chat with Ansible

### Configuring other chat backens

XXX

## Installing Open Webhooks on existing Hubot

This is for you if you have Hubot already running on a server or you
don't want to install Hubot using ansible.

[Install Hubot](https://github.com/github/hubot/blob/master/docs/deploying/unix.md)

Install Open Webhook NPM package inside your Hubot installation::

    npm install hubot-open-webhook

Enable Open Webhook in Hubot. Edit `myhubot/external-scripts.json` and add it as external script:

    [..., "hubot-open-webhook"]






