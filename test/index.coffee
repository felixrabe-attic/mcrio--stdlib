require('chai').should()
stdlib = require('../')

describe 'stdlib.endsWith', ->
  it 'should accept empty string', ->
    stdlib.endsWith('', '').should.be.true
    stdlib.endsWith('', 'foo').should.be.false
    stdlib.endsWith('foo', '').should.be.true

describe 'stdlib.startsWith', ->
  it 'should accept empty string', ->
    stdlib.startsWith('', '').should.be.true
    stdlib.startsWith('', 'foo').should.be.false
    stdlib.startsWith('foo', '').should.be.true

describe 'String::endsWith', ->
  before ->
    stdlib.endsWith.monkey(ifExists: 'replace')

  it 'should accept empty string', ->
    ''.endsWith('').should.be.true
    ''.endsWith('foo').should.be.false
    'foo'.endsWith('').should.be.true

describe 'String::startsWith', ->
  before ->
    stdlib.startsWith.monkey(ifExists: 'replace')

  it 'should accept empty string', ->
    ''.startsWith('').should.be.true
    ''.startsWith('foo').should.be.false
    'foo'.startsWith('').should.be.true

describe 'stdlib.replacePrefix', ->
  it 'should accept empty strings', ->
    stdlib.replacePrefix('', '', '').should.equal ''
    stdlib.replacePrefix('', '', 'bar').should.equal 'bar'
    stdlib.replacePrefix('foo', '', 'bar').should.equal 'barfoo'

  it 'should replace prefix', ->
    stdlib.replacePrefix('one foo', 'one', 'two').should.equal 'two foo'

  it 'should throw exceptions when string does not start with prefix', ->
    (->
      stdlib.replacePrefix '', 'foo', ''
    ).should.Throw '\'\' does not start with \'foo\''
    (->
      stdlib.replacePrefix '123456', 'foo', ''
    ).should.Throw '\'123456\' does not start with \'foo\''

describe 'stdlib.replaceSuffix', ->
  it 'should accept empty strings', ->
    stdlib.replaceSuffix('', '', '').should.equal ''
    stdlib.replaceSuffix('', '', 'bar').should.equal 'bar'
    stdlib.replaceSuffix('foo', '', 'bar').should.equal 'foobar'

  it 'should replace suffix', ->
    stdlib.replaceSuffix('one foo', 'foo', 'bar').should.equal 'one bar'

  it 'should throw exceptions when string does not end with suffix', ->
    (->
      stdlib.replaceSuffix '', 'foo', ''
    ).should.Throw '\'\' does not end with \'foo\''
    (->
      stdlib.replaceSuffix '123456', 'foo', ''
    ).should.Throw '\'123456\' does not end with \'foo\''

describe 'stdlib.splitOnce', ->
  it 'should accept empty strings', ->
    stdlib.splitOnce('', '').should.deep.equal ['', '']

  it 'should split once', ->
    stdlib.splitOnce('a b c', ' ').should.deep.equal ['a', 'b c']

describe 'stdlib.withoutOne', ->
  withoutOneAssert = (input, element, expected) ->
    stdlib.withoutOne(input, element).should.deep.equal expected

  it 'should remove one element if found', ->
    withoutOneAssert ['a', 'b', 'c'], 'a', ['b', 'c']
    withoutOneAssert ['a', 'b', 'c'], 'b', ['a', 'c']
    withoutOneAssert ['a', 'b', 'c'], 'c', ['a', 'b']

  it 'should remove the first occurrence of an element if found', ->
    withoutOneAssert ['a', 'b', 'c', 'b'], 'b', ['a', 'c', 'b']

  it 'should not change the array if element was not found', ->
    withoutOneAssert ['a', 'b', 'c'], 'd',  ['a', 'b', 'c']
    withoutOneAssert ['a', 'b', 'c'], null, ['a', 'b', 'c']
    withoutOneAssert ['a', 'b', 'c'], 0,    ['a', 'b', 'c']
