{connect} = require 'mqtt'
{model} = require '../model/stock'

module.exports =
  mqtt:
    client:
      connect process.env.MQTTURL,
        username: process.env.MQTTUSER
        clientId: process.env.MQTTCLIENT
        clean: false
      .on 'connect', ->
        @subscribe process.env.MQTTTOPIC, qos: 2
      .on 'message', (topic, msg) ->
        {action, data} = JSON.parse msg.toString()
        {stock} = global.config
        if topic == 'stock'
          switch action
            when 'subscribe'
              for code in data
                try
                  if code not of stock
                    {name} = await model.findOne code: code
                    stock[code] = name
                  @publish 'stock/hkex', JSON.stringify
                    src: 'hkex'
                    symbol: code
                    name: stock[code]
                catch err
                  console.error "error to fetch #{code}"
            when 'unsubscribe'
              data.map (code) ->
                delete stock[code]
