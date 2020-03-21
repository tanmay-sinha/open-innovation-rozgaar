from flask import Flask
from flask import request
import json
import database.database as db
app = Flask(__name__)

@app.route("/add_database", methods=['POST'])
def add_labour_database():
    if request.method == 'POST':
        data = request.json
        print(data["name"])
        db.data_entry(data["name"], data["age"],2 ,data["gender"],
        23.4, 86.5, 200)
        return 'OK'

@app.route("/get_details", methods=['GET', 'POST'])
def get_details_from_database():
    if request.method == 'POST':
        data = request.json


if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0')
