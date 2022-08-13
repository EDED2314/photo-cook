import requests
import os
from dotenv import load_dotenv

load_dotenv()


def send(detections):
    string = ""
    for detect in detections:
        string += detect + ","
    params = {
        "apiKey": os.getenv("API-KEY"),
        "includeIngredients": string
    }
    url = "https://api.spoonacular.com/recipes/complexSearch"
    response = requests.get(url, params=params)
    response = response.json()
    return response


print(send(['tomato']))
