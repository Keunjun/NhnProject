var sys = require('sys'), url = require('url'), http = require('http'), qs = require('querystring');

var analyze = function(src) {
	jsmeter = require('./jsmeter.js').jsmeter;
	var name = ""; // path.match(/([^\/])\.js$/)[1];
	var result = jsmeter.run(src, name);
//	for ( var i = 0; i < result.length; i++) {
//		console.log(name, result[i].name.replace(/^\[\[[^\]]*\]\]\.?/, ""));
//		console.log(" line start: %d", result[i].lineStart);
//		console.log(" lines:      %d", result[i].lines);
//		console.log(" statements: %d", result[i].s);
//		console.log(" comments:   %d", result[i].comments);
//		console.log(" complexity: %d", result[i].complexity);
//		console.log(" M.I.:       %d", result[i].mi);
//	}
	return result;
}

http.createServer(function(req, res) {
	res.writeHead(200, {
		'Content-Type' : 'text/plain'
	});
	var args;

	if (req.method == 'POST') {
		var body = '';
		req.on('data', function(data) {
			body += data;
		});
		req.on('end', function() {
			var args = qs.parse(body);
//			console.log(args);
		});
	} else if (req.method == 'GET') {
		var args = url.parse(req.url, true).query;
//		console.log(args);
	}

	if (args.mode == 'CC') {
		res.end(JSON.stringify(analyze(args.src)));
	} else {
		res.end();
	}
}).listen(1337, "127.0.0.1");
