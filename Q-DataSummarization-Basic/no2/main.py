import os
import csv
import pandas as pd

dirname = os.getcwd()

with open(dirname + '/data/accesslog_02.csv') as f:
    accesslog_data = list(csv.reader(f))
    accesslog_data = pd.DataFrame(accesslog_data[1:], columns=[accesslog_data[0][0],accesslog_data[0][1],accesslog_data[0][2]])
    

answer_data = accesslog_data.groupby(['REQUEST_TIME','IP_ADDRESS'], as_index=False).count()
answer_data = answer_data.rename(columns={'ID': 'count'})

# 10以上の場合は0とする
answer_data['count'] = answer_data['count'].apply(lambda x : 0 if x >= 10 else x)

answer_data = answer_data.groupby(['REQUEST_TIME'], as_index=False).sum()
answer_data = answer_data.values.tolist()


with open(dirname + '/data/accesslog_02.answer.csv', 'w') as f:
    writer = csv.writer(f, lineterminator = '\n')
    writer.writerows(answer_data)
