_ = require 'lodash'
moment = require 'moment'
news = require '../model/news'
stock = require '../model/stock'
{HKEXList, HKEXNew} = require 'hkex'

module.exports = 
  hkex:
    news: ->
      last = await news.last()
      console.log "get news starting from #{last?.releasedAt.toString()} at #{new Date().toString()}"
      hkex = new HKEXNew dtStart: moment last?.releasedAt
      for await i from hkex.iter()
        found = await news.model.findOne i
        if found?
          break
        else
          await news.model.insert i
    stock: ->
      try
        for await i from HKEXList()
          curr = await stock.model.findOne _.pick(i, 'code')
          i = _.pick i, stock.attributes
          if curr?
            await stock.model.update _.pick(i, 'code'), $set: i
          else
            await stock.model.insert i
      catch err
        console.error err
