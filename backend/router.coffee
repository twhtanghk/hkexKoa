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
code = (ctx, next) ->
  ctx.params.code = ctx.params.code.padStart 5, '0'
  await next()

module.exports = router
  .get '/api/news', news.find
  .get '/api/stock', stock.find
  .get '/api/stock/:code', code, stock.findOne
