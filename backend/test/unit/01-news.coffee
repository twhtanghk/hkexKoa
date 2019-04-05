req = require 'supertest'

describe 'hkex', ->
  {HKEXNew} = require 'hkex'
  hkex = new HKEXNew()
  store = require '../../model/news'

  it 'get hkex news', ->
    for await i from hkex.iterAll()
      console.log i

  it 'save hkex news into db', ->
    for await i from hkex.iterAll()
      await store.model.insert i
