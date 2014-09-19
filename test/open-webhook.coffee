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
    @robot =
      router: express()
      respond: ->
        return

    process.env.OPEN_WEBHOOK_SECRET = "xxx"
    require('../src/open-webhook')(@robot)

  it 'acceps MD5 signed messages', (done) ->
    msg = "x"
    chat = "y"
    md5 =

    request(@robot.router).post(, {body: 'My room', msg: 'foobar'})
      .expect(200)
      .end ->
        console.log "Err"
        done()

  it 'discards MD5 messages with bad signature', ->
    return

  it 'accepts unsigned messages', ->
    return