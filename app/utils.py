import os
import re
import subprocess
import tempfile
import zipfile
from typing import Any, AnyStr, Dict, List

import jinja2
from settings import APP_ROOT, TEST_DATA, USER_DATA


def render_template(base_uri) -> str:
    context = get_all_data()
    context["base_uri"] = base_uri

    env = jinja2.Environment(
        loader=jinja2.FileSystemLoader(os.getcwd()),
    )
    jinja2_template = env.get_template("jbrowse2.jinja2")
    return jinja2_template.render(context)


def get_all_data() -> Dict[str, Any]:
    def get_paths(path) -> List[Dict[str, AnyStr]]:
        dirs = []
        for root, _, files in os.walk(path):
            if "config.json" not in files:
                continue

            rel_path = os.path.relpath(root, APP_ROOT)
            name = " ".join(re.split(r"[._-]+", os.path.basename(root))).title()
            dirs.append({"name": name, "path": rel_path})

        # Nice to have sorted listing
        return sorted(dirs, key=lambda x: x["name"])

    return {
        "test_data": get_paths(os.path.join(APP_ROOT, TEST_DATA)),
        "user_data": get_paths(os.path.join(APP_ROOT, USER_DATA)),
    }


def process_zip(filepath: str):
    with tempfile.TemporaryDirectory() as tmpdir:
        with zipfile.ZipFile(filepath) as zfh:
            zfh.extractall(tmpdir)

        output = "/user_data/samples"
        os.makedirs(output, exist_ok=True)
        subprocess.run(
            ["/app/bootstrap_samples.sh", tmpdir, output],
            cwd=tmpdir,
            stdout=subprocess.DEVNULL,
        )
