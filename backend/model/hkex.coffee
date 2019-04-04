db = require 'jsOAuth2/backend/model/db'
Model = require 'jsOAuth2/backend/model/model'

class HKEx extends Model
  name: 'hkex'

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

  constructor: ->
    super()

  last: ->
    @model
      .find()
      .sort releasedAt: -1
      .limit 1

module.exports = new HKEx()
