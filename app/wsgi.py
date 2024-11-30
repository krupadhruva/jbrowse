payload = [b"<h1 style='color:blue'>Hello There!</h1>",
            b"<a href=http://localhost:8080/jbrowse/?config=test_data/volvox/config.json>Sample</a>",
            ]

class JbrowseWsgiApp(object):
    def __init__(self, environ, start_response):
        self.environ = environ
        self.start = start_response

    def __iter__(self):
        status = '200 OK'
        response_headers = [('Content-type', 'text/html')]
        self.start(status, response_headers)
        return iter(payload)

# application = JbrowseWsgiApp
