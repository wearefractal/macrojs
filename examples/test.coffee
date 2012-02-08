macro = require '../index'
fs = require 'fs'
path = require 'path'

infile = path.join __dirname, 'example.js'
outfile = path.join __dirname, 'example.out.js'

file = fs.readFileSync infile

macro.define 'debug', (node) ->
  out = "console.log('Debug at line #{node.line}');"
  out += "console.trace();"
  return out

macro.define 'topload', (path, node) -> return "require('../#{path}');"
macro.define 'lrequire', (path, node) ->  return "require('./#{path}');"
macro.define 'add', (numone, numtwo, node) -> return "#{numone + numtwo};"
macro.define '//', (comment, node) -> return "console.log('we swaggin');" if comment is '#SWAG'
macro.define '/*', (comments, node) -> return "console.log('swaggin hard bro');" if comments[0] is 'we swaggin'

# Test raw input
output = macro.process file
fs.writeFileSync outfile, output


# Test require() override
#macro.register()
#require './example.js'