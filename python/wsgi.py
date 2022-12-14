from flask import Flask, render_template, jsonify, request
import os
from recipe import send
from detect.predict import get_detections

app = Flask(__name__)
app.config["SECRET_KEY"] = f"{os.urandom(24).hex()}"

@app.route('/', methods=["GET"])
def home():
    return render_template("index.html")

@app.route('/api/cook', methods=["GET", 'POST'])
def process_image_get_detections():
    images = request.files.getlist("images")
    if len(images) == 0 and request.method == "POST":
        return jsonify({"error": "400", "message": "Please make sure you are sending an image with the request!"})
    if request.method == "POST":
        for image in images:
            amount_of_images = len(os.listdir("Images"))
            image.save(os.path.join("Images", f"{amount_of_images + 1}.jpg"))
            return ""
    elif request.method == "GET":
        copy_response = {}
        amount_of_images = len(os.listdir("Images"))
        class_labels = get_detections(os.path.join("Images", f"{amount_of_images}.jpg"))
        response = send(class_labels)

        for result in response['results']:
            idd = result['id']
            title = result['title']
            title = title.replace(" ", "-")
            idx = response['results'].index(result)
            response['results'][idx]["url"] = "https://spoonacular.com/recipes/"+title + f"-{idd}"

        response['detections'] = class_labels
        print(response)
        return jsonify(response)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
