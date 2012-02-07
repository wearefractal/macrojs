macro = require '../index'
fs = require 'fs'
path = require 'path'

infile = path.join __dirname, 'example.js'
outfile = path.join __dirname, 'example.out.js'

file = fs.readFileSync infile

macro.add 'debug', (node) ->
  out = "console.log('Debug at line #{node.line}')\r\n"
  out += "console.trace()"
  return out

macro.add 'topload', (path, node) -> "require('../#{path}')"
macro.add 'lrequire', (path, node) -> "require('./#{path}')"
macro.add 'add', (numone, numtwo, node) -> String numone + numtwo
output = macro.run file

fs.writeFileSync outfile, output