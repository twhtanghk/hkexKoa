scheduler = require 'node-schedule'

module.exports =
  bootstrap: ->
    process.on 'SIGTERM', =>
      @hkex()
    @cron.map (at) ->
      ret = scheduler
        .scheduleJob at, =>
          try
            @hkex()
          catch err
            console.error err
