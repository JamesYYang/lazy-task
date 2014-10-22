crypto = require("crypto")

_is = exports.is = (type, obj)->
  clas = Object.prototype.toString.call(obj).slice(8, -1)
  return obj isnt undefined && obj isnt null && clas is type

exports.getHash = (data) ->
  if _is("Object", data)
    data = JSON.stringify(data)
  crypto.createHash("md5").update(data).digest "hex"