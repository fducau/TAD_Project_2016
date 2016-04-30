import pandas as pd 
import numpy as np 
from sklearn.cross_validation import train_test_split



def col_renamer(data_frame):
    data_renamed = data_frame.rename(columns={'Study Title (O)': 'title',
                                                'Replicate (R)': 'replicate',
                                                'Completion (R)':'complete'})
    return data_renamed


def remove_not_completed(ds):
    ds = ds[ds.complete == 1]
    return ds

def split_train_test(ds):




def main():

    #Load dataset
    #downloaded from https://osf.io/yt3gq/
    ds = pd.read_csv('./rpp_data_updates.csv', index_col=0, sep=',')

    necessary_columns = ["Study Title (O)","Replicate (R)","Completion (R)"]
    ds_1 = ds[necessary_columns]
    ds_1 = col_renamer(ds_1)
    ds_complete = remove_not_completed(ds_1)
    #Drop complete column
    ds_complete.drop('complete', inplace=True, axis=1)
    #Change yes, no with 1, 0
    mapping_dict = {'yes':1, 'no':0, 'Yes':1, 'No':0}
    ds_complete = ds_complete.replace({'replicate':mapping_dict})
    
    #Remove duplicated entries
    duplicated = [50, 149]
    ds_complete = ds_complete.drop(duplicated)
    train, test = train_test_split(ds_complete, train_size=0.8)

    #Save clean dataset
    train.to_csv('train.csv', sep='\t')
    train.to_csv('test.csv', sep='\t')





if __name__ == '__main__':
    main()