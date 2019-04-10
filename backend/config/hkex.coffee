moment = require 'moment'
news = require '../model/news'
{HKEXNew} = require 'hkex'

module.exports =
  hkex: ->
    last = await news.last()
    console.log "get news starting from #{last?.releasedAt.toString()} at #{new Date().toString()}"
    hkex = new HKEXNew dtStart: moment last?.releasedAt
    for await i from hkex.iterAll()
      releasedAt = moment i.releasedAt
      if last == null or moment(last.releasedAt).isBefore releasedAt
        news.model.insert i
      else
        break
