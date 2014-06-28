monkey = (cls, method) ->
  module.exports[method].monkey = ->
    cls::[method] = (args...) ->
      module.exports[method] @, args...

module.exports = stdlib =
  # http://stackoverflow.com/a/2548133/1034080
  endsWith: (string, suffix) ->
    string.indexOf(suffix, string.length - suffix.length) != -1

  # Just monkey-patch everything
  monkey: -> method.monkey?() for own n, method of stdlib

monkey String, 'endsWith'
