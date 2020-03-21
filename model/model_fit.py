import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler as sc
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression,Ridge
from pickle import dump



class Model:
    lin_reg=Ridge()
    xscaler=sc()
    yscaler=sc()
    poly=PolynomialFeatures(degree=3)
    #Function to extract from DataFrame the necessary columns
    def extract(self,df):
        y=df['Score']
        df=df.drop(['labour_id','Name','skill','Latitudes','Longitudes','Score'],axis=1)
        x=df
        return x,y
    #Function to be called after extract for preprocessing
    def preprocess(self,x,y):
        gen=x['Gender']
        y=np.array(y).reshape((1,len(y)))
        x=self.poly.fit_transform(x)
        x=self.xscaler.fit_transform(x)
        y=np.ravel(y)
        y=np.reshape(np.array(y),(len(y),1))
        y=self.yscaler.fit_transform(y)
        x=pd.DataFrame(x)
        x[0]=gen
        dump(self.xscaler, open('xscaler+ve.pkl', 'wb'))
        dump(self.yscaler, open('yscaler+ve.pkl', 'wb'))
        dump(self.poly, open('poly.pkl', 'wb'))
        return x,y

    #Function for input preprocessting
    def preprocess_input(self,x):
        x= self.poly.transform(x)
        x=self.xscaler.transform(x)
        return x

    #Function to fit the model on x and y
    def fitmodel(self,x,y):
        k=self.lin_reg.fit(x,y)
        dump(self.lin_reg, open('model+ve.pkl', 'wb'))
        print(k)

    #Function to Check if the model is predicting as expected
    def predict(self,x):
        y_pred= self.lin_reg.predict(x)
        #print(x.shape)
        return self.yscaler.inverse_transform(y_pred)


if __name__=='__main__':
    obj=Model()
    df= pd.read_csv('C:/Users/sriva/nitr/nitrhack/labor/agepositive.csv')
    #print(df.columns)
    #['Age','Gender','Income','Distance','WorkIntensity']
    l2=[[26,0,1000,8,4],[36,1,1000,3,4],[25,0,1000,20,4]]
    x,y=obj.extract(df)
    x,y=obj.preprocess(x,y)
    obj.fitmodel(x,y)
    pre= obj.preprocess_input(l2)
    
    ans= obj.predict(pre)
    print(ans)
    
    
