scheduler = require 'node-schedule'

module.exports =
  bootstrap: ->
    process.on 'SIGTERM', =>
      @cron.map ({at, task}) ->
        task()
    @cron.map ({at, task}) =>
      scheduler.scheduleJob at, =>
        try
          task()
        catch err
          console.error err
    @
