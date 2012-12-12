var req = new axton.data.ajax.Request();
req.url = "/node/jsmeter?mode=JSON";
req.callback = function(id, obj, text, time, req, xhr) {
	var d = {
		text : "",
		write : function(t) {
			if (t === 0) {
				t = "0";
			}
			t = t || "";
			if (typeof t !== "string") {
				t = t.toString();
			}
			this.text = this.text + t;
		}
	};

	obj.forEach(function(fns, index, fs) {
		for (i in fns) {
			if (!Array[i] && !Array.prototype[i]) {
				if (fns[i].errorMessage) {
					d.write("<tr>");
					d.write("<td colspan='13' style='text-align:center;'>");
					d.write("<span style='color: red;'>");
					d.write(fns[i].errorMessage);
					d.write("</span>");
					d.write("</td>");
					d.write("</tr>");
				} else {
					d.write("<tr>");
					d.write("<td>");
					d.write(fns[i].lineStart);
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].name.replace("[[code]].", ""));
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].s);
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].lines);
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].comments);
					d.write("</td>");
					d.write("<td>");
					d.write(Math.round(fns[i].comments / (fns[i].lines) * 10000) / 100
							+ "%");
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].b);
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].blockDepth);
					d.write("</td>");
					d.write("<td " + (comp > 11 ? "style=\"color:red\"" : "") + ">");
					d.write(fns[i].complexity);
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].halsteadVolume);
					d.write("</td>");
					d.write("<td>");
					d.write(fns[i].halsteadPotential);
					d.write("</td>");
					d.write("<td "
							+ (fns[i].halsteadLevel < 0.01 ? "style=\"color:red\"" : "")
							+ ">");
					d.write(fns[i].halsteadLevel);
					d.write("</td>");
					d
							.write("<td " + (fns[i].mi < 100 ? "style=\"color:red\"" : "")
									+ ">");
					d.write(fns[i].mi);
					d.write("</td>");
					d.write("</tr>");
				}
			}
		}

		$("results").innerHTML = d.text;
	});

	// try {
	// renderFiles($("results"), obj, renderMode);
	// window.location.href = "#results";
	// } catch (ex) {
	// alert(ex);
	// }
};
//req.callerror = function(id, obj, text) {
//};
req.method = "POST";
req.data = ("var x;" || " ").replace(/\r/g, "");
axton.data.ajax.queue.add(req);