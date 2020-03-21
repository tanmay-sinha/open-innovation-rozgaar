import sqlite3
import random
import time
import json
from geopy.distance import distance as dis
conn = sqlite3.connect('database/labourers.db')
cursor = conn.cursor()


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


def find_distance(contractor_lat, contractor_long,
                  labour_lat, labour_long):
    coord1 = (contractor_lat, contractor_long)
    coord2 = (labour_lat, labour_long)
    return dis(coord1, coord2).km


def data_retrieval(skill, latitudes, longitudes):
    cursor.execute(
        f'''SELECT * FROM labourer_details WHERE skill={skill}'''
    )
    input_data = []
    for row in cursor.fetchall():
        labourer = [row[2], row[4], row[7]]
        distance = find_distance(latitudes, longitudes, row[5], row[6])
        distance = round(distance, 3)
        labourer.append(distance)
        input_data.append(labourer)
    print(input_data)


if __name__ == "__main__":
    pass
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

    # cor1 = (23.745541, 86.343521)
    # cor2 = (23.412358, 85.439989)

    # print(distance(cor1, cor2))
