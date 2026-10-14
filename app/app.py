import os
import socket

from flask import Flask, jsonify

app = Flask(__name__)
VERSION = os.environ.get("APP_VERSION", "dev")


@app.get("/")
def index():
    return jsonify(
        message="Hello from the cloud pipeline",
        version=VERSION,
        host=socket.gethostname(),
    )


@app.get("/health")
def health():
    return jsonify(status="ok")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
