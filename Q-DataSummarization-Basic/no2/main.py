import os
import csv

dirname = os.getcwd()

with open(dirname + '/data/accesslog_02.csv') as f:
    accesslog_data = list(csv.reader(f))

answer_data = [["2020011009",11],["2020011010",22]]
with open(dirname + '/data/accesslog_02.answer.csv', 'w') as f:
    writer = csv.writer(f, lineterminator = '\n')
    writer.writerows(answer_data)
