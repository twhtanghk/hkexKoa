store = require '../model/news'

module.exports =
  bootstrap: ->
    @cron.map (at) ->
      require 'node-schedule'
        .scheduleJob at, =>
          console.log "get news starting from #{@last?.toString()} at #{new Date().toString()}"
          hkex = new HKEXNew dtStart: @last
          for await i from reverse hkex.iterAll()
            releasedAt = moment i.releasedAt
            @last ?= releasedAt
            if @last.isBefore releasedAt
              @emit 'data', i
            @last = moment.max @last, releasedAt
