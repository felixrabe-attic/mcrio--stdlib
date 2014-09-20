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

module.exports = stdlib =
  # http://stackoverflow.com/a/646643
  endsWith: monkeyable String, 'endsWith', (string, other) ->
    other == '' or string.slice(-other.length) == other

  # http://stackoverflow.com/a/646643
  startsWith: monkeyable String, 'startsWith', (string, other) ->
    string.slice(0, other.length) == other

  replacePrefix: monkeyable String, 'replacePrefix', (string, oldPrefix, newPrefix) ->
    unless stdlib.startsWith string, oldPrefix
      throw new Error "'#{string}' does not start with '#{oldPrefix}'"
    newPrefix + string.slice oldPrefix.length

  replaceSuffix: monkeyable String, 'replaceSuffix', (string, oldSuffix, newSuffix) ->
    unless stdlib.endsWith string, oldSuffix
      throw new Error "'#{string}' does not end with '#{oldSuffix}'"
    string.slice(0, string.length - oldSuffix.length) + newSuffix

  # http://stackoverflow.com/a/2878746/1034080
  splitOnce: monkeyable String, 'splitOnce', (string, separator) ->
    i = string.indexOf(separator)
    [string.slice(0, i), string.slice(i+1)]

  withoutOne: monkeyable Array, 'withoutOne', (array, element) ->
    index = array.indexOf(element)
    if index > -1
      array.splice index, 1
    return array

  # Monkey-patch all methods
  monkey: -> method.monkey?() for method in allMonkeyables
