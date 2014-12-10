# Description:
#
#   Send chat messages to Hubot from extenral services.
#
# Configuration:
#
#   OPEN_WEBHOOK_SECRET:
#     Shared MD5 signing key
#
#   OPEN_WEBHOOK_DISABLE_UNSIGNED:
#     Set this environment variable to disable
#     sending in messages without signing.
#
#   OPEN_WEBHOOK_QUIET:
#     Don't give hints to the user

crypto = require 'crypto'

openWebhookSecret = process.env.OPEN_WEBHOOK_SECRET or "insecure"
openWebhookVerbose = not process.env.OPEN_WEBHOOK_QUIET

if openWebhookSecret == "insecure"
    console.warn "Please give OPEN_WEBHOOK_SECRET environment variable. Using insecure defaults."

allowUnsigned = not process.env.OPEN_WEBHOOK_DISABLE_UNSIGNED

###* Proces chat messages
# @param {object} robot Hubot instance
# @param {object} req HTTP request
# @param {object} res HTTP response
# @param {string} hasher Hashing algorithm like 'md5'. Optional.
###
processMessage = (robot, req, res) ->

  if not req.body
    console.error "Could not parse request body"
    res.status(500)
    return

  # Sevabot legacy parameter mapping
  room = req.body.chat or req.body.chat_id
  msg = req.body.msg or req.body.message

  if not room
    err = "Missing chat parameter"
    console.error err
    res.status(500).send(err)
    return

  if not msg
    err = "Missing msg parameter"
    console.error err
    res.status(500).send(err)
    return

  robot.messageRoom room, msg

  res.send 'OK'

module.exports = (robot) ->

  # Show where we are listeting
  if openWebhookVerbose
    console.log robot.server
    console.log robot.server.address()
    # ip = robot.server.address().address
    # ip = ip.replace "0.0.0.0", "127.0.0.1"
    # port = robot.server.address().port
    # console.log "Chat open webhook is available at http://#{ip}:#{port}/hubot/openwebhook/#{openWebhookSecret}/"

  # open-webhook ping
  # https://en.wikipedia.org/wiki/Marsupilami
  robot.respond /happy/i, (msg) ->
    msg.reply "Huba huba huba"

  # open-webhook ping
  robot.respond /sad/i, (msg) ->
    username = msg.message.user.name or "you"
    msg.reply "#{ robot.name } loves #{ username }"

  # XMPP specific debug command to give out XMPP fully qualified room name
  robot.respond /xmpp/i, (msg) ->
      #msg.envelope.user.type = 'direct'
      msg.send "Hey #{msg.envelope.user.name}! You told me in XMPP room #{msg.envelope.user.room} to talk to you."
      console.log msg.envelope.user.room

  robot.router.post "/hubot/openwebhook/#{openWebhookSecret}/", (req, res) ->
    processMessage robot, req, res

  robot.router.get "/hubot/openwebhook/#{openWebhookSecret}/", (req, res) ->
    processMessage robot, req, res
