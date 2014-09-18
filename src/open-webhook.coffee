# Description:
#
#   Send chat messages to Hubot from extenral services.
#
# Configuration:
#
#   OPEN_WEBHOOK_SECRET
#
#


# Proces MD5 signed payloads
processMD5Signed = (robot, req, res) ->
    console.log req.body.payload
    console.log req.body

    room = req.body.chat
    msg = req.body.msg

    robot.messageRoom room, msg

    res.send 'OK'

module.exports = (robot) ->

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
    robot.router.post '/hubot/openwebhook/md5signed', (req, res) ->
        processMD5Signed robot, req, res

    robot.router.get '/hubot/openwebhook/md5signed', (req, res) ->
        processMD5Signed robot, req, res
