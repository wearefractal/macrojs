burrito = require 'burrito'
cs = require 'coffee-script'
fs = require 'fs'

macros = {}

define = (name, fn) -> macros[name] = fn
remove = (name) -> delete macros[name]

process = (code, filename) ->
  return code unless macros? and Object.keys(macros).length > 0
  burrito code, (node) ->
    node.start.filename = filename if filename? and node.start?
    if node.name is 'call' and macros[node.start.value]?
      args = (arg[arg.length-1] for arg in node.value[1])
      out = macros[node.start.value] args..., node.start
      node.wrap out if out?
    else if node.start? and node.start.comments_before.length > 0
      args = (arg.value for arg in node.start.comments_before)
      if args.length is 1
        macro = macros['//']
        out = macro args[0], node.start if macro?
      else
        macro = macros['/*']
        out = macro args, node.start if macro?
      node.wrap "#{out}\r\n%s;" if out?

register = ->
  if require.extensions
    require.extensions['.coffee'] = (module, filename) ->
      content = cs.compile fs.readFileSync(filename, 'utf8'), {filename}
      content = process content, filename
      module._compile content, filename
    require.extensions['.js'] = (module, filename) ->
      content = fs.readFileSync(filename, 'utf8')
      content = process content, filename
      module._compile content, filename
  else if require.registerExtension
    require.registerExtension '.coffee', (content) -> process cs.compile content
    require.registerExtension '.js', (content) -> process content

module.exports =
  define: define
  remove: remove
  register: register
  process: process
  macros: macros