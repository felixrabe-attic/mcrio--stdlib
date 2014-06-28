allMonkeyables = []

monkeyable = (cls, methodName, method) ->
  method.monkey = (opts = {}) ->
    opts.ifExists ?= 'keep'  # valid values: keep, replace, fail
    if cls::[methodName]?
      switch opts.ifExists
        when 'fail'
          m = "Method already exists: #{cls.name}.prototype.#{methodName}"
          throw new Error m
        when 'keep'
          return
    cls::[methodName] = (args...) ->
      method @, args...
    return
  allMonkeyables.push method
  method

module.exports =
  # http://stackoverflow.com/a/646643
  endsWith: monkeyable String, 'endsWith', (string, other) ->
    other == '' or string.slice(-other.length) == other

  # http://stackoverflow.com/a/646643
  startsWith: monkeyable String, 'startsWith', (string, other) ->
    string.slice(0, other.length) == other

  # Monkey-patch all methods
  monkey: -> method.monkey?() for method in allMonkeyables
