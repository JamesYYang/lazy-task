container = require("./container")

exports = module.exports = ->
  if !container.settings
    container.initContainer()

  return container