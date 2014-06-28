monkey = (cls, method) ->
  module.exports[method].monkey = ->
    cls::[method] = (args...) ->
      module.exports[method] @, args...

module.exports = stdlib =
  # http://stackoverflow.com/a/2548133/1034080
  endsWith: (string, other) ->
    string.indexOf(other, string.length - other.length) != -1

  # Monkey-patch all methods
  monkey: -> method.monkey?() for own n, method of stdlib

monkey String, 'endsWith'
