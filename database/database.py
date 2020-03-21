import sqlite3
import random
import time
import json
import requests
import googlemaps
conn = sqlite3.connect('database/labourers.db')
cursor = conn.cursor()

with open('api.json') as f:
    API_KEY = json.load(f)["API_KEY"]


def create_table():
    cursor.execute('''CREATE TABLE IF NOT EXISTS labourer_details(
        labourer_id INTEGER,
        name TEXT,
        age INTEGER,
        skill INTEGER,
        gender INTEGER,
        latitudes REAL,
        longitudes REAL,
        income INTEGER
    )''')


def data_entry(labourer_id, name, age, skill, gender,
               latitudes, longitudes, income):
    cursor.execute('''INSERT INTO labourer_details (
        labourer_id, name, age, skill, gender,
               latitudes, longitudes, income
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''', (
        labourer_id, name, age, skill, gender,
        latitudes, longitudes, income
    ))
    conn.commit()


def find_distance():
    pass


def data_retrieval(skill, latitudes, longitudes):
    cursor.execute(
        f'''SELECT * FROM labourer_details WHERE skill={skill}'''
    )


if __name__ == "__main__":
    # create_table()
    # names = ['tanmay', 'anshuman', 'ankan', 'shreyash',
    #          'raju', 'babu rao', 'shyam', 'hello', 'world']
    # for i in range(51):
    #     labourer_id = i+1
    #     name = random.choice(names)
    #     age = random.randint(18, 60)
    #     skill = random.randint(1, 10)
    #     gender = random.randint(0, 1)
    #     latitudes = round(random.uniform(23.65, 23.85), 3)
    #     longitudes = round(random.uniform(86.30, 86.50), 3)
    #     income = random.randint(1, 10)*100
    #     data_entry(labourer_id, name, age, skill, gender,
    #                latitudes, longitudes, income)
    #     time.sleep(1)
    # data_retrieval(5, 23.43, 86.5)
    # cursor.close()
    # conn.close()
    # URL = "https://maps.googleapis.com/maps/api/distancematrix/json?"
    # r = requests.get(
    #     URL+f"origins=23.745541,86.343521&destinations=23.412358,85.439989&key={API_KEY}")
    # print(r.json())
    gmaps = googlemaps.Client(key=f'{API_KEY}')
    my_dist = gmaps.distance_matrix('Delhi','Mumbai')['rows'][0]['elements'][0]
    print(my_dist)