# Description:
#
#   Send chat messages to Hubot from extenral services.
#
# Configuration:
#
#   OPEN_WEBHOOK_SECRET

crypto = require 'crypto'

openWebhookSecret = process.env.OPEN_WEBHOOK_SECRET



# Proces MD5 signed payloads
processMD5Signed = (robot, req, res) ->

  # Sevabot legacy parameter mapping
  room = req.body.chat or req.body.chat_id
  msg = req.body.msg or req.body.message
  payloadHash = req.body.md5

  if not room
    console.error "Payload missing chat room"
    return

  if not msg
    console.error "Payload missing msg"
    return

  if not openWebhookSecret
    err = "Cannot decode incoming message. OPEN_WEBHOOK_SECRET environment variable missing."
    console.error err
    robot.messageRoom room, err
    return

  expectedHash = crypto.createHash('md5')
            .update(room)
            .update(msg)
            .update(openWebhookSecret)
            .digest("hex")

  if payloadHash != expectedHash
    err = "Message MD5 hash mismatch. Got #{payloadHash}, expected #{expectedHash}. Payload #{room} #{msg}"
    console.error err
    robot.messageRoom room, err
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

  # HTTP endpoints

  #
  # HTTP form parameters
  # - chat
  # - msg
  # - md5
  #
  robot.router.post '/hubot/openwebhook/signed/md5/', (req, res) ->
    processMD5Signed robot, req, res

  robot.router.get '/hubot/openwebhook/signed/md5/', (req, res) ->
    processMD5Signed robot, req, res
