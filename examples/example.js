var appcfg = topload('config');
var dbcfg = lrequire('db_config');
var coolmod = load('namespace.coolmod');

var sum = add(1, 2);
console.log(sum);
debug();

var coolfn = function () {
  debug();
};
coolfn();