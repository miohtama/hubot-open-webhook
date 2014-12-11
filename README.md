
*hubot-open-webhook* is a [Hubot](https://hubot.github.com/) extension allowing you
to easily send chat messages to any chat service from services you maintain or program.
It is useful for software development, workflow automatization, server monitoring
and other business automatization.

Hubot Open Webhook features

* Sending chat messages using HTTP/HTTPS from shell scripting or any programming language

* Good documentation how to set everything up, so you can get it working even with the most junior sysadmin skills

# Supported chat networks and applications

Hubot is a chat bot maintained by Github and written in CoffeeScript programming language running on NodeJS.
It supports [multiple chat networks](https://github.com/github/hubot/blob/master/docs/adapters.md), including XMPP,
GTalk and IRC.

Note that there are several chat services aimed for software development with internal tools with similar,  polished, automatizing functionality e.g. [Flowdock](http://flowdock.com/). The benefits of using Hubot include

* Free, no paid subscriptions required

* Completely self-hosted, can work inside intranets

* Supports any chat services, e.g. ones your organization is already using internally, like XMPP

* Fully customizable: not limited to scripting of web hooks of chat service provider

# Requirements

You need to install these on your system to get started

* [Node.js](http://nodejs.org/)

* [NPM](http://npmjs.org/)

# Install

[Installation Hubot, Open Webhook and chat adapters automatically using Ansible](docs/install.md)

[Installation Open Webhook on the existing Hubot installation by hand](docs/install.md)

# Usage

[Sending in chat messages from shell scripts](docs/usage.md)

[Sending in chat messages from Python](docs/usage.md)

# Chat backends

[Setting up Hubot and Open Webhook with XMPP](docs/xmpp.md)

[Setting up Hubot and Open Webhook with Google GTalk](docs/gtalk.md)

[For other chat backends see the relevant Hubot adapter instructions](https://github.com/github/hubot/blob/master/docs/adapters.md)

# Development

Hubot allows you to write webhooks with [Express Node.js web application framework](http://expressjs.com/).
Open Webhook endpoints try to be as generic as possible, so that you can easily use
and extend them without need to write chat bot code yourself.

[See development documentation](docs/development.md)

# History

This project aims to reimplement ato implement Sevabot, the friendly Skype bot, functionality in Hubot.
Sevabot served well as an extensible Skype bot. However, Microsoft started to shutdown Skype APIs for third parties, so one no longer can effectively run and maintain Skype chat bots with the guarantee they work tomorrow.

Meanwhile, Hubot project had grown popular. Thus, it was time to bury Sevabot and migrate the innovation
born in Sevabot project to another open ecosystem.

# Author

Mikko Ohtamaa
