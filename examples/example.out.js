var appcfg = require("../config");

var dbcfg = require("./db_config");

var coolmod = load("namespace.coolmod");

console.log("begin test");

console.log("we swaggin");

var sum = 3;

console.log(sum);

console.log("Debug at line 10");

console.trace();

console.log("swaggin hard bro");

var coolfn = function() {
    console.log("Debug at line 15");
    console.trace();
};

coolfn();