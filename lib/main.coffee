burrito = require 'burrito'
cs = require 'coffee-script'
fs = require 'fs'

macros = {}

add = (name, fn) -> macros[name] = fn
remove = (name) -> delete macros[name]

run = (code, filename) ->
  return code unless macros? and Object.keys(macros).length > 0
  burrito code, (node) ->
    if node.name is 'call' and macros[node.start.value]?
      args = (arg[arg.length-1] for arg in node.value[1])
      out = macros[node.start.value] args..., node.start
      node.filename = filename if filename?
      node.wrap out

register = ->
  if require.extensions
    require.extensions['.coffee'] = (module, filename) ->
      content = cs.compile fs.readFileSync(filename, 'utf8'), {filename}
      content = run content, filename
      module._compile content, filename
    require.extensions['.js'] = (module, filename) ->
      content = fs.readFileSync(filename, 'utf8')
      content = run content, filename
      module._compile content, filename
  else if require.registerExtension
    require.registerExtension '.coffee', (content) -> run cs.compile content
    require.registerExtension '.js', (content) -> run content

module.exports =
  add: add
  remove: remove
  register: register
  run: run
  macros: macros