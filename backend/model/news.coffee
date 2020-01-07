db = require 'koamodel/db'
Model = require 'koamodel'

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
    await @model
      .findOne {}, sort: releasedAt: -1

module.exports = new News()
