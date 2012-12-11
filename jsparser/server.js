var http = require("http");

http.createServer(function(req, res) {
	res.writeHead(200, {
		"Content-Type" : "text/plain"
	});

	jsmeter = require('./jsmeter.js');
	res.write(jsmeter.run());
	res.end();
}).listen(8080);