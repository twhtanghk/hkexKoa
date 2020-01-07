Model = require 'koamodel'

class Stock extends Model
  name: 'stock'

  attributes: [
    'code'
    'name'
    'category'
    'sub-category'
    'lot'
    'value'
    'isin'
    'expiry date'
    'stamp duty'
    'shortsell eligible'
    'cas eligible'
    'vcm eligible'
    'stock options'
    'stock futures'
    'ccass'
    'etf'
    'debt securities board lot'
    'debt securities investor type'
  ]

module.exports = new Stock()
