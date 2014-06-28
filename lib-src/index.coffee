monkey = (cls, method) ->
  module.exports[method].monkey = ->
    cls::[method] = (args...) ->
      module.exports[method] @, args...

module.exports = stdlib =
  # http://stackoverflow.com/a/646643
  endsWith: (string, other) ->
    other == '' or string.slice(-other.length) == other

  # Monkey-patch all methods
  monkey: -> method.monkey?() for own n, method of stdlib

monkey String, 'endsWith'
