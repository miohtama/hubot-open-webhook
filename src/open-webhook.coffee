#

module.exports = (robot) ->
    robot.respond /sad/i, (msg) ->
        username = msg.message.user.name or "you"
        msg.reply "#{ robot.name } loves #{ username }"
