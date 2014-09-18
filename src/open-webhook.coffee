#

module.exports = (robot) ->
    robot.respond /sad/, (msg) ->
        console.log "Test"
        msg.reply "Hello"
