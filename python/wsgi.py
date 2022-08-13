from flask import Flask, render_template, session, url_for, make_response, jsonify, request
import json

app = Flask(__name__)
app.config["SECRET_KEY"] = f"{os.urandom(24).hex()}"

@app.route('/', methods=["GET"])
def home():
    return render_template("index.html")

if __name__ == '__main__':
    app.run(host="127.0.0.1", port=5000, debug=True)
