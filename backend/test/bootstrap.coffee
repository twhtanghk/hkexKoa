before ->
  global.server = await require '../index'

after ->
  global.server.close()
  process.exit()
