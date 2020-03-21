from flask import Flask
from flask import request
import json
import database.database as db
app = Flask(__name__)

@app.route("/add_database")
def add_labour_database():
    data = request.get_json()
    print(data)
    db.data_entry()

@app.route("/getdetails")
def get_details_from_database():
    db.data_retrieval()

if __name__ == "__main__":
    app.run(debug=True)
