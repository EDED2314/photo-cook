from flask import Flask, render_template, jsonify, request
import os
from recipe import send
from detect.predict import get_detections

app = Flask(__name__)
app.config["SECRET_KEY"] = f"{os.urandom(24).hex()}"

@app.route('/', methods=["GET"])
def home():
    return render_template("index.html")

@app.route('/api/cook', methods=["GET"])
def process_image_get_detections():
    images = request.files.getlist("images")
    image_names = []
    response = {}
    for image in images:
        image_name = image.filename
        image_names.append(image_name)
        amount_of_images = len(os.listdir("Images"))
        image.save(os.path.join("Images", f"{amount_of_images+1}.jpg"))
        class_labels = get_detections(os.path.join("Images", f"{amount_of_images+1}.jpg"))
        response = send(class_labels)
        response['detections'] = class_labels
    return jsonify(response)

if __name__ == '__main__':
    app.run(host="127.0.0.1", port=5000, debug=True)
