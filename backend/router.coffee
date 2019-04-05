Router = require 'koa-router'
router = new Router()
hkex = require './model/news'
  .actions [
    'find'
  ]

module.exports = router
  .get '/api/hkex', hkex.find
