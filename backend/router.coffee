Router = require 'koa-router'
router = new Router()
news = require './model/news'
  .actions [
    'find'
  ]
stock = require './model/stock'
  .actions [
    'find'
    'findOne'
  ]

module.exports = router
  .get '/api/news', news.find
  .get '/api/stock', stock.find
  .get '/api/stock/:code', stock.findOne
