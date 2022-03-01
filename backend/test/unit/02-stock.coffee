req = require 'supertest'

describe 'stock', ->
  {HKEXList} = require 'hkex'
  store = require '../../model/stock'

  it 'stock list', ->
    for await row from HKEXList()
      store.model.insert row
