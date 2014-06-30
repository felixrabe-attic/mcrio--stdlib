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
