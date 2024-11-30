import os
import re
from typing import Any, Dict, List

import jinja2

root_dir = '/usr/share/nginx/html/jbrowse'
test_data = 'test_data'
user_data = 'user_data'

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
        # more_payload = [f'<br>{self.environ}</br>'.encode()]
        base_uri = f'http://{self.environ["HTTP_HOST"]}/jbrowse'
        return iter([JbrowseWsgiApp.render_template(base_uri).encode()])
        # return iter(itertools.chain(payload, more_payload))

    @staticmethod
    def render_template(base_uri) -> str:
        context = JbrowseWsgiApp.get_all_data()
        context['base_uri'] = base_uri

        env = jinja2.Environment(loader=jinja2.FileSystemLoader(os.getcwd()), )
        jinja2_template = env.get_template('jbrowse2.jinja2')
        return jinja2_template.render(context)

    @staticmethod
    def get_all_data() -> Dict[str, Any]:
        def get_paths(path) -> List[Dict[str, str]]:
            dirs = []
            for root, _, files in os.walk(os.path.join(root_dir, path)):
                if 'config.json' not in files:
                    continue

                rel_path = os.path.relpath(root, root_dir)
                name = ' '.join(re.split(r'[._-]+', os.path.basename(root))).title()
                dirs.append({'name': name, 'path': rel_path})

            return dirs

        return {
            'test_data': get_paths(os.path.join(root_dir, test_data)),
            'user_data': get_paths(os.path.join(root_dir, user_data)),
        }


if __name__ == '__main__':
    root_dir = '/Users/dkrishnamurthy/jira/stub/git/krupa/jbrowse'
    print(f'{JbrowseWsgiApp.render_template("http://localhost:8080/jbrowse")}')
