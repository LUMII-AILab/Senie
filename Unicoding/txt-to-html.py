#!/usr/local/bin/python3
import os
import sys

dir = os.path.join("..", "Web", "unicode")

if not os.path.isdir(dir):
	print("Directory '{}' does not exist".format(dir))
	sys.exit(-1)

for f in os.listdir(dir):
	if not f.endswith("_Unicode.txt"):
		continue

	name = f[0:f.index("_Unicode.txt")]
	html = open(os.path.join(dir, name + ".htm"), "w")

	html.write("<html>")
	html.write("<head>")
	html.write("<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\">")
	html.write("<title>" + name + "</title>")
	html.write("</head>")
	html.write("<body><pre>")

	with open(os.path.join(dir, f)) as txt:
		for line in txt:
			html.write(line)

	html.write("</pre></body></html>")

	html.close()
	os.remove(os.path.join(dir, f))
