import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler as sc
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression,Ridge
from pickle import dump, load

class Model:
    model_positive=load(open('model/model+ve.pkl', 'rb'))
    xscaler_poistive=load(open('model/xscaler+ve.pkl', 'rb'))
    yscaler_positive=load(open('model/yscaler+ve.pkl', 'rb'))
    model_negative=load(open('model/model-ve.pkl', 'rb'))
    xscaler_negative=load(open('model/xscaler-ve.pkl', 'rb'))
    yscaler_negative=load(open('model/yscaler-ve.pkl', 'rb'))
    poly=load(open('model/poly.pkl', 'rb'))

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
        #Now x is Dictionary of lists
        xs=[]
        indexes={}
        c=0
        for key,value in x.items():
            indexes[c]=key
            c+=1
            xs.append(value)
            
        xs=np.array(xs)
        x= self.poly.transform(xs)
        xscaler=sc()
        if type=='+':
            xscaler=self.xscaler_positive
        elif type=='-':
            xscaler=self.xscaler_negative
        x=xscaler.transform(x)
        return x,indexes

    #after preprocess_input call predict to get a list of predicted scores for laborers
    def predict(self,x,type,indexes):
        model=Ridge()
        yscaler=sc()
        if type=='+':
            model=self.model_positive
            yscaler=self.yscaler_positive
        elif type=='-':
            model=self.model_negative
            yscaler=self.yscaler_negative
        
        y_pred= model.predict(x)
        y_pred= yscaler.inverse_transform(y_pred)
        idscores={}
        for i in range(len(indexes)):
            idscores[indexes[i]]=y_pred[i][0]
        return idscores


if __name__=='__main__':
    obj=Model()
    #Input format Lists of Lists [[age,gender,income,distance,workintensity](labor 1),[age,gender,...](labor2),...etc]
    #========NOTE====>> All functions contain type as parameter in which you need to pass '+' or '-' depending upon the work will be age prefered positively or negatively
    l2={2:[26,0,200,8,9],5:[36,1,1000,3,9],8:[25,0,1000,20,9]}
    pre,index= obj.preprocess_input(l2,'-')
    ans= obj.predict(pre,'-',index)
    print(ans)
    
    
