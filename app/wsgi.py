import json
import os
import pathlib
import tempfile
from urllib import request as urllib_request

import jinja2
from flask import Flask, flash, redirect, request
from settings import APP_NAME, USER_DATA
from utils import process_zip, render_template
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config["SECRET_KEY"] = APP_NAME
app.config["USER_DATA"] = os.path.join("/", USER_DATA)
app.config["UPLOAD_FOLDER"] = os.path.join(app.config["USER_DATA"], "uploads")
if not os.path.exists(app.config["UPLOAD_FOLDER"]):
    os.makedirs(app.config["UPLOAD_FOLDER"])

# Constant HTML upload payload
upload_html = """
<!doctype html>
<link rel="preconnect" href="https://rsms.me/">
<link rel="stylesheet" href="https://rsms.me/inter/inter.css">

<style>
    /* CSS */
    root {
        font-family: Inter, sans-serif;
        font-feature-settings: 'liga' 1, 'calt' 1; /* fix for Chrome */
    }

    @supports (font-variation-settings: normal) {
        :root {
            font-family: InterVariable, sans-serif;
        }
    }
</style>

<iframe name="home" width="100%" height="30px" scrolling="no"
        src="/home.html">
</iframe>

<title>Samples upload</title>
<h3>Upload zip file with samples</h3>
<form method=post enctype=multipart/form-data>
    <input type=file name=file>
    <input type=submit value=Upload>
</form>
"""


@app.route("/wsgi/")
def index():
    base_url = request.base_url.rstrip("/").rstrip(request.path)
    jb_url = f"{base_url}/{APP_NAME}"
    return render_template(jb_url).encode()


def allowed_file(filename):
    return pathlib.Path(filename).suffix in [".gz", ".zip"]


@app.route("/upload/", methods=["GET", "POST"])
def upload_file():
    if request.method == "POST":
        # check if the post request has the file part
        if "file" not in request.files:
            flash("No file part")
            return redirect(request.url)
        file = request.files["file"]
        # If the user does not select a file, the browser submits an
        # empty file without a filename.
        if file.filename == "":
            flash("No selected file")
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            file.save(filepath)
            process_zip(filepath)
            os.unlink(filepath)

            return redirect("/")

    return upload_html


@app.route("/download/", methods=["GET", "POST"])
def download_links():
    if request.method == "POST":
        selected_links = request.form.getlist("links")
        if len(selected_links) == 0:
            return redirect(request.url)

        for link in selected_links:
            filepath = tempfile.mktemp("links-")
            urllib_request.urlretrieve(link, filepath)
            process_zip(filepath)
            os.unlink(filepath)

        return redirect("/")

    try:
        with open(os.path.join(app.config["USER_DATA"], "links.json")) as fp:
            context = json.load(fp)
    except FileNotFoundError:
        context = {"links": []}

    env = jinja2.Environment(
        loader=jinja2.FileSystemLoader(os.getcwd()),
    )
    jinja2_template = env.get_template("download-links.jinja2")
    return jinja2_template.render(context)


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host="0.0.0.0", debug=True, port=80)
