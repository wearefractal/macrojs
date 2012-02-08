## Information

<table>
<tr>
<td>Package</td><td>macrojs</td>
</tr>
<tr>
<td>Description</td>
<td>Macros for nodejs</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
</table>

## Usage

### Defining macros - .define

You only need to define your macros and use register() once when your app starts

```coffee-script
macro = require 'macro'
macro.define 'debug', (node) ->
  out = "console.log('Debug at line #{node.line}')\r\n"
  out += "console.trace()"
  return out

macro.define 'debug', (node) ->
  out = "console.log('Debug at line #{node.line}');"
  out += "console.trace();"
  return out

macro.define 'topload', (path, node) -> return "require('../#{path}');"
macro.define 'lrequire', (path, node) ->  return "require('./#{path}');"
macro.define 'add', (numone, numtwo, node) -> return String(numone + numtwo)
macro.define '//', (comment, node) -> return "console.log('we swaggin');" if comment is '#SWAG'
macro.define '/*', (comments, node) -> return "console.log('swaggin hard bro');" if comments[0] is 'we swaggin'
```

will replace

```javascript
var appcfg = topload('config');
var dbcfg = lrequire('db_config');
var sum = add(1, 3);
debug();
```

with

```javascript
var appcfg = require("../config");
var dbcfg = require("./db_config");
var sum = 4;
console.log("Debug at line 3");
console.trace();
```

### Registering files - .register()

All files loaded with require() will be passed through the macro transformer before being loaded.

This is what most people should be using.

```coffee-script
macro = require 'macro'
macro.register()
# Define your macros here
```

### Raw input - .process()

Pass in a string of JS, get out a string of transformed JS.

This is used behind the scenes with register() and only useful if you want to process your files at build-time.

```coffee-script
macro = require 'macro'
fs = require 'fs'
# Define your macros here

input = fs.readFileSync "coolinput.js"
output = macro.process input
fs.writefileSync output, "coolinput.out.js"
```

## Examples

You can view further examples in the [example folder.](https://github.com/wearefractal/macrojs/tree/master/examples)

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
