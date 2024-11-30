
def application(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    return [b"<h1 style='color:blue'>Hello There!</h1>",
            b"<a href=http://localhost:8080/jbrowse/?config=test_data/volvox/config.json>Sample</a>",
            ]
