import pandas as pd 
import numpy as np 



def col_renamer(data_frame):
    data_renamed = data_frame.rename(columns={'Study Title (O)': 'title',
                                                'Replicate (R)': 'replicate',
                                                'Completion (R)':'complete'})
    return data_renamed


def remove_not_completed(ds):
    ds = ds[ds.complete == 1]
    return ds



def main():

    #Load dataset
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
    #Save clean dataset
    ds_complete.to_csv('replication_dataset.csv', sep='\t')





if __name__ == '__main__':
    main()