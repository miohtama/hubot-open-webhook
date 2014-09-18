# Description:
#
#   Send chat messages to Hubot from extenral services.
#
# Configuration:
#
#   OPEN_WEBHOOK_SECRET
#
#


module.exports = (robot) ->

    processMD5Signed = (req, res) ->
        console.log req.body.payload

        room = req.params.room
        data = JSON.parse req.body.payload
        secret = data.secret

        robot.messageRoom room, "I have a secret: #{secret}"

        res.send 'OK'

    # open-webhook ping
    robot.respond /sad/i, (msg) ->
        username = msg.message.user.name or "you"
        msg.reply "#{ robot.name } loves #{ username }"

    # HTTP endpoints

    robot.router.post '/hubot/openwebhook/md5signed', (req, res) ->
        prcoessMD5Signed req, res

    robot.router.get '/hubot/openwebhook/md5signed', (req, res) ->
        prcoessMD5Signed req, res
