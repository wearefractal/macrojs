macro = require '../index'
fs = require 'fs'
path = require 'path'

infile = path.join __dirname, 'example.js'
outfile = path.join __dirname, 'example.out.js'

file = fs.readFileSync infile

macro.add 'topload', (path) -> return "require('../#{path}')"
macro.add 'lrequire', (path) -> return "require('./#{path}')"
output = macro.run file

fs.writeFileSync outfile, output