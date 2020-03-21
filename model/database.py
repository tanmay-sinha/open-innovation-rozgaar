import sqlite3
import random
import time
conn = sqlite3.connect('labours_tanmay.db')
c = conn.cursor()

#labours_tanmay contains two tables one labour_deatils for age+ve and labours_details2 for age -ve
def create_table():
    c.execute('''CREATE TABLE IF NOT EXISTS labour_details2(
        labour_id INTEGER,
        Name TEXT,
        Age INTEGER,
        skill INTEGER,
        Gender INTEGER,
        Latitudes REAL,
        longitudes REAL,
        Income INTEGER,
        Score DECIMAL,
        Distance INTEGER,
        Intensity INTEGER
    )''')


def data_entry(labour_id, name, age, skill, gender,
               latitudes, longitudes, income,score,d,intensity):
    c.execute('''INSERT INTO labour_details2(
        labour_id, Name, Age, skill, Gender,
               Latitudes, Longitudes, Income,Score,Distance,Intensity
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', (
        labour_id, name, age, skill, gender,
        latitudes, longitudes, income,score,d,intensity
    ))
    conn.commit()


if __name__ == "__main__":

    create_table()
    names = ['tanmay', 'anshuman', 'ankan', 'shreyash',
             'raju', 'babu rao', 'shyam', 'hello', 'world']
    for i in range(0,51):
        labour_id = i+1
        name = random.choice(names)
        age = random.randint(18, 60)
        skill = random.randint(1, 10)
        gender = random.randint(0, 1)
        latitudes = round(random.uniform(23.65, 23.85), 3)
        longitudes = round(random.uniform(86.30, 86.50), 3)
        income = random.randint(1,10)*100
        d=random.randint(1,25)
        score=0

        if d<=12:        
            if income<=500:
                    if age>50:               #Change this to age<=35 if creating data for age+ve 
                        score=random.randint(95,100)
                    elif age>35 and age<=50:
                        score=random.randint(85,95)
                    elif age<=35:           #Change this to age> 50 if creating data for age+ve
                        score=random.randint(80,85)
            elif income>500 and income<=800:
                    if age>50:                 #Do above changes for all the below appropiate if statements (if for +ve) 
                        score=random.randint(75,80)
                    elif age>35 and age<=50:
                        score=random.randint(65,75)
                    elif age<=35:              #**
                        score=random.randint(60,65)  
            elif income>800:
                    if age>50:                #**
                        score=random.randint(55,60)
                    elif age>35 and age<=50:    
                        score=random.randint(50,55)
                    elif age<=35:           #**
                        score=random.randint(40,45)
        else:
            if income<=500:
                    if age>50:              #**
                        score=random.randint(38,45)
                    elif age>35 and age<=50:
                        score=random.randint(33,38)
                    elif age<=35:               #**
                        score=random.randint(30,33)
            elif income>500 and income<=800:
                    if age>50:                  #**
                        score=random.randint(25,35)
                    elif age>35 and age<=50:
                        score=random.randint(20,25)
                    elif age<=35:               #**
                        score=random.randint(15,20)
            elif income>800:
                    if age>50:                  #**
                        score=random.randint(14,20)
                    elif age>35 and age<=50:
                        score=random.randint(12,14)
                    elif age<=35:               #**
                        score=random.randint(5,12)

        intensity=0
        if gender==1:
            intensity=random.randint(1,6)
        else:
            intensity=random.randint(5,10)
    
                
        data_entry(labour_id, name, age, skill, gender,
                   latitudes, longitudes, income,score,d,intensity)
        # time.sleep(1)

    c.close()
    conn.close()
