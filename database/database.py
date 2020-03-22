''' Entering, retrieving and maintaining the labourer's database. '''

import sqlite3
import random
import time
import json
from geopy.distance import distance as dis
conn = sqlite3.connect('database/labourers.db', check_same_thread=False)
cursor = conn.cursor()

cursor.execute("SELECT max(labourer_id) from labourer_details")
global count_labourers
count_labourers = cursor.fetchone()[0]

skill_2 = {1: 7,
           2: 6,
           3: 9,
           4: 7,
           5: 6,
           6: 5,
           7: 10,
           8: 8,
           9: 8,
           10: 6
           }


def create_table():
    ''' creating the table in the database '''
    cursor.execute('''CREATE TABLE IF NOT EXISTS labourer_details(
        labourer_id INTEGER,
        name TEXT,
        age INTEGER,
        skill INTEGER,
        gender INTEGER,
        latitudes REAL,
        longitudes REAL,
        income INTEGER,
        contact TEXT
    )''')


def data_entry(name, age, skill, gender,
               latitudes, longitudes, income, contact):
    '''Entering data into the database'''
    global count_labourers
    labourer_id = count_labourers + 1

    cursor.execute('''INSERT INTO labourer_details (
        labourer_id, name, age, skill, gender,
               latitudes, longitudes, income, contact
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', (
        labourer_id, name, age, skill, gender,
        latitudes, longitudes, income, contact
    ))
    count_labourers = count_labourers + 1
    conn.commit()


def find_distance(contractor_lat, contractor_long,
                  labour_lat, labour_long):
    '''finding distance between two co-ordinates on map'''
    coord1 = (contractor_lat, contractor_long)
    coord2 = (labour_lat, labour_long)
    return round(dis(coord1, coord2).km, 3)


def data_retrieval(skill, latitudes, longitudes):
    '''retreiving the data from database to be sent to the model'''
    cursor.execute(
        f'''SELECT * FROM labourer_details WHERE skill={skill}'''
    )
    input_data = {}
    for row in cursor.fetchall():
        id_r = row[0]
        input_data[id_r] = [row[0], row[4], row[7]]
        input_data[id_r].append(find_distance(
            latitudes, longitudes, row[5], row[6]
        ))
        input_data[id_r].append(skill_2[skill])
    # /print(input_data)
    return input_data


def get_complete_details(id_, dist):
    '''getting details to be sent to the contractor'''
    cursor.execute(
        f'''SELECT * FROM labourer_details WHERE labourer_id={id_}'''
    )
    jsondata = {}
    for row in cursor.fetchall():
        jsondata["name"] = row[1]
        jsondata["age"] = row[2]
        if row[4] == 1:
            jsondata["gender"] = "male"
        else:
            jsondata["gender"] = "female"
        jsondata["distance"] = dist
        jsondata["contact"] = row[8]

    return jsondata


def close_databae():
    '''closing the database'''
    cursor.close()
    conn.close()


if __name__ == "__main__":

    ''' Generating random datasets for testing'''
    create_table()
    names = ['tanmay', 'anshuman', 'ankan', 'shreyash',
             'raju', 'babu rao', 'shyam', 'hello', 'world']
    for i in range(51):
        labourer_id = i+1
        name = random.choice(names)
        age = random.randint(18, 60)
        skill = random.randint(1, 10)
        gender = random.randint(0, 1)
        latitudes = round(random.uniform(23.65, 23.85), 3)
        longitudes = round(random.uniform(86.30, 86.50), 3)
        income = random.randint(1, 10)*100
        contact = ''.join(["{}".format(random.randint(0, 9))
                           for num in range(0, 10)])
        data_entry(name, age, skill, gender,
                   latitudes, longitudes, income, contact)

        # time.sleep(1)
    data_retrieval(5, 23.43, 86.5)
    cursor.close()
    conn.close()
