from flask import Flask, request
from settings import APP_NAME
from utils import render_template

app = Flask(__name__)
app.config["SERVER_NAME"] = "localhost:8080"


@app.route("/wsgi")
def index():
    base_url = request.base_url.rstrip("/").rstrip(request.path)
    jb_url = f"{base_url}/{APP_NAME}"
    return render_template(jb_url).encode()


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host="0.0.0.0", debug=True, port=80)
