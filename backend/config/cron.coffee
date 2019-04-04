module.exports = 
  cron: [
    # run per minute for every weekday from 09:00 - 15:59
    "0 * 9-15 * * * 1-5"
    # run per 30 minute from 00-8:00 or 16:00 - 23:00 for everyday
    "0 */30 0-8,16-23 * * * *"
  ]
