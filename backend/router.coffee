Router = require 'koa-router'
router = new Router()
news = require './model/news'
  .actions [
    'find'
  ]

module.exports = router
  .get '/api/news', news.find
