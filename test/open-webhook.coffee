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

describe 'open-webhook', ->
  beforeEach ->

    # Mock up Hubot object
    @robot =
      router: express()
      respond: ->
        return

    process.env.OPEN_WEBHOOK_SECRET = "xxx"
    require('../src/open-webhook')(@robot)

  it 'Accepts messages to secret endpoint', (done) ->

    request(@robot.router).post("/hubot/openwebhook/xxx/")
      .send({body: 'Hello Hubot', msg: 'foobar'})
      .expect(200)
      .end (req, resp) ->
        done()

  it 'Discards messages without known secret', ->

    request(@robot.router).post("/hubot/openwebhook/yyy/")
      .send({body: 'Hello Hubot', msg: 'foobar'})
      .expect(404)

