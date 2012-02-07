var appcfg = require("../config");

var dbcfg = require("./db_config");

var coolmod = load("namespace.coolmod");

var sum = 3;

console.log(sum);

console.log("Debug at line 6");

console.trace();

var coolfn = function() {
    console.log("Debug at line 9");
    console.trace();
};

coolfn();