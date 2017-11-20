# -*- coding: utf-8 -*-
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import json


class HttpProcessor(BaseHTTPRequestHandler):
    def do_POST(self):
        
        print self.path
        
        length = int(self.headers["Content-Length"])
        print length
        buf = self.rfile.read(length)
        f = open('movie.mov', 'w')
        f.write(buf)
        
        response = json.dumps(json.load(open('../movsea/Resources/Test.txt')))
        
        self.send_response(200)  # create header
        self.send_header("Content-Length", str(len(response)))
        self.end_headers()
        self.wfile.write(response)  # send response


serv = HTTPServer(("", 8080), HttpProcessor)
print 'I start serving'
serv.serve_forever()
