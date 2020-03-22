from flask import Flask
from flask import request
import json
import database.database as db
import model.model as predictor
app = Flask(__name__)

obj = predictor.Model()

skills = {"Carpentry": [1, 7, "-"],
          "Painting": [2, 6, "+"],
          "Masonry": [3, 9, "-"],
          "Plumbing": [4, 7, "+"],
          "Electrician": [5, 6, "+"],
          "Cleaner": [6, 5, "+"],
          "Rigger": [7, 10, "-"],
          "Transport": [8, 5, "+"],
          "Welder": [9, 8, "-"],
          "Fitter": [10, 6, "-"]
          }

gender = {"male": 1,
          "female": 2}


@app.route("/add_database", methods=['POST'])
def add_labour_database():
    '''addition to the labourer's database'''
    if request.method == 'POST':
        data = request.json
        db.data_entry(data["name"], data["age"], skills[data["skills"]][0], gender[data["gender"].lower()],
                      round(data["location"]["latitude"], 3), round(data["location"]["longitude"], 3), 0)
        return 'OK'


@app.route("/get_details", methods=['GET', 'POST'])
def get_details_from_database():
    '''getting data from database and predicting the labourers. '''
    if request.method == 'POST':
        data = request.json
        skill = skills[data["skill"]]
        input_data = db.data_retrieval(skill[0], round(data["location"]["latitude"], 3),
                                       round(data["location"]["longitude"], 3))

        pre, index = obj.preprocess_input(input_data, skill[2])
        ans = obj.predict(pre, skill[2], index)

        ans = {k: v for k, v in sorted(ans.items(), key=lambda item: item[1])}

        jsondata = []

        for id_ in ans:
            jsondata.append(db.get_complete_details(id_, input_data[id_][3]))

        jsondata = json.dumps(jsondata)
        print(jsondata)
        return jsondata


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
