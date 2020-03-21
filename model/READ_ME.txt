This folder contains files for prediction of score for a labor depending upon his age, gender,income and workintensity

All pkl files are saved weights and biases
There are two models in this folder 'model+ve.pkl' and 'model-ve.pkl'.
The '+ve' and '-ve' means that '+ve' model is trained on giving more preference to labor with less age and vice 
versa for '-ve'

model.py is the main model file which contains two basic functions of preprocessing input and prediction.(Refer the file for input formats)

xscaler and yscaler pkl files stores the mean and standard deviation of trained data to preprocess and transform test data.

model_fit.py is python script to retrain the model pkl files

database.py is python script to create data on which the model will be train.

agepositive.csv and agenegative.csv are sample of created dataset using SQLlite3 in labours_tanmay.db 


********NOTE******
In Gender : 0 as consdered as male and 1 for female