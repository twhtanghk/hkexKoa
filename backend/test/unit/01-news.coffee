req = require 'supertest'

describe 'hkex', ->
  {HKEXNew} = require 'hkex'
  hkex = new HKEXNew()
  store = require '../../model/news'

  it 'get hkex news', ->
    try
      for await i from hkex.iterAll()
        console.log i
    catch err
      console.error err

  it 'save hkex news into db', ->
    try
      for await i from hkex.iterAll()
        await store.model.insert i
    catch err
      console.error err

  it 'last hkex news', ->
    try
      console.log await store.last()
    catch err
      console.error err
