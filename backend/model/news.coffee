db = require 'jsOAuth2/backend/model/db'
Model = require 'jsOAuth2/backend/model/model'

db.addMiddleware ({collection}) -> (next) -> (args, method) ->
  if collection.name == 'news' and method == 'insert'
    if News.match args.data
      next args, method
  else
    next args, method

class News extends Model
  name: 'news'

  attributes: [
    'code'
    'name'
    'type'
    'typeDetail'
    'title'
    'link'
    'size'
    'releasedAt'
  ]

  @pattern: new RegExp process.env.ALERT

  @match: (data) ->
    {typeDetail, type, title} = data
    News.pattern.test(typeDetail) or
    News.pattern.test(type) or
    News.pattern.test(title)

  last: ->
    @model
      .find()
      .sort releasedAt: -1
      .limit 1

module.exports = new News()
