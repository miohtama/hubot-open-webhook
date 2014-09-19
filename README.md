
Open-webhook-chat is a [Hubot](https://hubot.github.com/) chat bot script allowing you
to send chat notifications from external services.
It is useful for software development, workflow automatization, server monitoring
and other business automatization.

Hubot Open Webhook features

* Sending chat messages from shell scripting or any programming language

* Pushing chat messages using HTTP/HTTPS requests

* Good documentation how to set everything up, so you can get it working even with the most junior sysadmin skills

# Supported chat networks and applications

Hubot is a chat bot maintained by Github and written in CoffeeScript / NodeJS.
It supports [multiple chat networks](https://github.com/github/hubot/blob/master/docs/adapters.md), including XMPP,
GTalk and IRC.

Hubot allows you to write webhooks with [Express Node.js web application framework](http://expressjs.com/).
Open Webhook endpoints try to be as generic as possible, so that you can easily use
and extend them without need to write chat bot code yourself.

# Dependencies

* NodeJS

* NPM

# Install

[See installation documentation](docs/install.md)

# Development

[See development documentation](docs/development.md)

# History

This project aims to reimplement ato implement Sevabot, the friendly Skype bot, functionality in Hubot.
Sevabot served well as an extensible Skype bot. However, Microsoft started to shutdown Skype APIs for third parties, so one no longer can effectively run and maintain Skype chat bots with the guarantee they work tomorrow.

Meanwhile, Hubot project had grown popular. Thus, it was time to bury Sevabot and migrate the innovation
born in Sevabot project to another open ecosystem.

# Author

Mikko Ohtamaa
