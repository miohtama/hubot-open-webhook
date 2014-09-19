#
# Useful URLS:
#
# https://github.com/visionmedia/supertest
#
#
chai = require 'chai'
crypto = require 'crypto'
express = require 'express'
expect = chai.expect
request = require 'supertest'
bodyParser = require 'body-parser'

describe 'open-webhook', ->
  beforeEach ->

    # Create express rotung
    router = express()
    router.use bodyParser()

    # Mock up Hubot object
    @robot =
      router: router
      messageRoom: ->
        return
      server:
        address: ->
            return {"address": "0.0.0.0", "port": 8080}
      respond: ->
        return

    process.env.OPEN_WEBHOOK_SECRET = "xxx"
    process.env.OPEN_WEBHOOK_QUIET = "true"
    require('../src/open-webhook')(@robot)

  it 'Accepts messages to secret endpoint', (done) ->

    request(@robot.router).post("/hubot/openwebhook/xxx/")
      .send({msg: 'Hello Hubot', chat: 'mychatroom'})
      .expect(200)
      .end (req, resp) ->
        done()

  it 'Discards messages without known secret', ->

    request(@robot.router).post("/hubot/openwebhook/yyy/")
      .send({msg: 'Hello Hubot', chat: 'foobar'})
      .expect(404)

