require('chai').should()
stdlib = require('../')

describe 'stdlib.endsWith', ->
  it 'should accept empty string', ->
    stdlib.endsWith('', '').should.be.true
    stdlib.endsWith('', 'foo').should.be.false
    stdlib.endsWith('foo', '').should.be.true

describe 'String::endsWith', ->
  before ->
    stdlib.endsWith.monkey()
  it 'should accept empty string', ->
    ''.endsWith('').should.be.true
    ''.endsWith('foo').should.be.false
    'foo'.endsWith('').should.be.true
