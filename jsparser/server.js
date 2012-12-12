//var http = require("http");
//
//http.createServer(function(req, res) {
//	res.writeHead(200, {
//		"Content-Type" : "text/plain"
//	});
//
//	
//	 res.write(jsmeter.run);
//	res.end();
//}).listen(8080);

jsmeter = require('./jsmeter.js').jsmeter;
var name = "x.js".match(/([^\/])\.js$/)[1];
var result = jsmeter.run("var x=function(){var y=1+1;};", name);
for ( var i = 0; i < result.length; i++) {
	console.log(name, result[i].name.replace(/^\[\[[^\]]*\]\]\.?/, ""));
	console.log(" line start: %d", result[i].lineStart);
	console.log(" lines:      %d", result[i].lines);
	console.log(" statements: %d", result[i].s);
	console.log(" comments:   %d", result[i].comments);
	console.log(" complexity: %d", result[i].complexity);
	console.log(" M.I.:       %d", result[i].mi);
}