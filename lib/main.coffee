burrito = require 'burrito'

###
Script = process.binding('evals').NodeScript
Script::runInThisContext
Script::runInNewContext
###
macros = {}

module.exports =
  add: (name, fn) -> macros[name] = fn
  remove: (name) -> delete macros[name]

  run: (code) ->
    burrito code, (node) ->
      console.log node.name
      if node.name is 'call' and macros[node.start.value]?
        # replace arg[arg.length-1] with burrito.deparse(arg) to pass true value.
        # good for code blocks  and functions but passes as string
        args = (arg[arg.length-1] for arg in node.value[1])
        out = macros[node.start.value] args...
        node.wrap out