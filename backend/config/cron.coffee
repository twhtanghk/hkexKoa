{hkex} = require './hkex'
{news, stock} = hkex

module.exports = 
  cron: [ 
    {
      at: [
        # run per minute for every weekday from 09:00 - 15:59
        "0 * 9-15 * * 1-5"
        # run per 30 minute for every weekday 00-8:00 or 16:00 - 23:00
        "0 */30 0-8,16-23 * * 1-5"
        # run per 30 minute on Sat or Sun
        "0 */30 * * * 0,6"
      ]
      task: news
    }
    {
      at: [
        "0 0 20 * * *"
      ]
      task: stock
    }
    {
      at: [
        "0 */3 9-15 * * 1-5"
      ]
      task: ->
        {stock, mqtt} = global.config
        for code, name of stock
          mqtt.client.publish 'stock/hkex', JSON.stringify
            src: 'hkex'
            symbol: code
            name: name
    }
  ]
