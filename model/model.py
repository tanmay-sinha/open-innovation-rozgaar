import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler as sc
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression,Ridge
from pickle import dump, load

class Model:
    model_positive=load(open('model+ve.pkl', 'rb'))
    xscaler_poistive=load(open('xscaler+ve.pkl', 'rb'))
    yscaler_positive=load(open('yscaler+ve.pkl', 'rb'))
    model_negative=load(open('model-ve.pkl', 'rb'))
    xscaler_negative=load(open('xscaler-ve.pkl', 'rb'))
    yscaler_negative=load(open('yscaler-ve.pkl', 'rb'))
    poly=load(open('poly.pkl', 'rb'))

    #If input is direct from database extract will prepare and drop unnecessary columns
    def extract(self,df):
        y=df['Score']
        df=df.drop(['labour_id','Name','skill','Latitudes','Longitudes','Score'],axis=1)
        x=df
        return x,y
    
    #If extract is called the inputs will be in original form so to scale and preprocess it 
    def preprocess(self,x,type):
        gen=x['Gender']
        xscaler=sc()
        if type=='+':
            xscaler=self.xscaler_positive
        elif type=='-':
            xscaler=self.xscaler_negative
            
        x=self.poly.transform(x)
        x=xscaler.transform(x)
        x=pd.DataFrame(x)
        x[0]=gen
        return x

    #if direct input of lists of list is given call this
    def preprocess_input(self,x,type):   
        x= self.poly.transform(x)
        xscaler=sc()
        if type=='+':
            xscaler=self.xscaler_positive
        elif type=='-':
            xscaler=self.xscaler_negative
        x=xscaler.transform(x)
        return x

    #after preprocess_input call predict to get a list of predicted scores for laborers
    def predict(self,x,type):
        model=Ridge()
        yscaler=sc()
        if type=='+':
            model=self.model_positive
            yscaler=self.yscaler_positive
        elif type=='-':
            model=self.model_negative
            yscaler=self.yscaler_negative
        
        y_pred= model.predict(x)
        return yscaler.inverse_transform(y_pred)


if __name__=='__main__':
    obj=Model()
    #Input format Lists of Lists [[age,gender,income,distance,workintensity](labor 1),[age,gender,...](labor2),...etc]
    #========NOTE====>> All functions contain type as parameter in which you need to pass '+' or '-' depending upon the work will be age prefered positively or negatively
    l2=[[26,0,200,8,9],[36,1,1000,3,9],[25,0,1000,20,9]]
    pre= obj.preprocess_input(l2,'-')
    ans= obj.predict(pre,'-')
    print(ans)
    
    
