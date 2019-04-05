req = require 'supertest'

describe 'hkex', ->
  it 'get hkex news', ->
    {HKEXNew} = require 'hkex'
    for await i from HKEXNew.iterAll()
      console.log i
