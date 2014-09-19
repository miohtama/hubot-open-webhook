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

crypto = require 'crypto'

openWebhookSecret = process.env.OPEN_WEBHOOK_SECRET

allowUnsigned = not process.env.OPEN_WEBHOOK_DISABLE_UNSIGNED

###* Proces chat messages
# @param {object} robot Hubot instance
# @param {object} req HTTP request
# @param {object} res HTTP response
# @param {string} hasher Hashing algorithm like 'md5'. Optional.
###
processMessage = (robot, req, res, hasher) ->

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

  if hasher

    if not openWebhookSecret
      err = "Cannot decode incoming message. OPEN_WEBHOOK_SECRET environment variable missing."
      console.error err
      res.status(500).send(err)
      return

    # req.body.md5
    payloadHash = req.body[hasher]

    expectedHash = crypto.createHash(hasher)
              .update(room)
              .update(msg)
              .update(openWebhookSecret)
              .digest("hex")

    if payloadHash != expectedHash
      err = "Message hash mismatch. Got #{payloadHash}, expected #{expectedHash}"
      console.error err
      res.status(500).send(err)
      return

  robot.messageRoom room, msg

  res.send 'OK'



module.exports = (robot) ->

  # open-webhook ping
  robot.respond /happy/i, (msg) ->
    msg.reply "Huba huba huba"

  # open-webhook ping
  robot.respond /sad/i, (msg) ->
    username = msg.message.user.name or "you"
    msg.reply "#{ robot.name } loves #{ username }"

  robot.respond /talk to me$/i, ( msg ) ->
    # Simply reply
    msg.reply "Hello #{msg.envelope.user.name}. Your private JID is #{msg.envelope.user.privateChatJID}"

  robot.respond /talk to me in private$/i, ( msg ) ->
    msg.envelope.user.type = 'direct'
    msg.send "Hey #{msg.envelope.user.name}! You told me in room #{msg.envelope.user.room} to talk to you."


  # HTTP endpoints with signing

  robot.router.post '/hubot/openwebhook/signed/md5/', (req, res) ->
    processMessage robot, req, res, "md5"

  robot.router.get '/hubot/openwebhook/signed/md5/', (req, res) ->
    processMessage robot, req, res, "md5"

  # Webhooks without signing protection
  if allowUnsigned

    robot.router.post '/hubot/openwebhook/unsigned/msg/', (req, res) ->
      processMessage robot, req, res, null

    robot.router.get '/hubot/openwebhook/unsigned/msg/', (req, res) ->
      processMessage robot, req, res, null
