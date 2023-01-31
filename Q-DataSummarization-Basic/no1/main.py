import os
import csv
import pandas as pd

dirname = os.getcwd()

with open(dirname + '/data/accesslog_01.csv') as f:
    accesslog_data = list(csv.reader(f))
    accesslog_data = pd.DataFrame(accesslog_data[1:], columns=[accesslog_data[0][0],accesslog_data[0][1],accesslog_data[0][2]])
    
with open(dirname + '/data/botlist_01.csv') as f:
    botlist_data = list(csv.reader(f))
    botlist_data = pd.DataFrame(botlist_data[1:], columns=[botlist_data[0][0],botlist_data[0][1]])
    botlist_data = botlist_data["BOT_IP_ADDRESS"].to_list()


df = pd.DataFrame(index=[], columns=["DATE","IP_ADDRESS","BOT"])

for idx, value in accesslog_data.iterrows():
    
    DATE = value["REQUEST_TIME"][:8]
    IP_ADDRESS = value["IP_ADDRESS"][:8]
    
    if value["IP_ADDRESS"] in botlist_data:
        BOT = 1
    else:
        BOT = 0
     
    df = pd.concat([df, pd.DataFrame([{'DATE':DATE, 'IP_ADDRESS': IP_ADDRESS , 'BOT': BOT}])])
    
# 集計
total = df.groupby(['DATE'], as_index=False).count()
total = total.rename(columns={'IP_ADDRESS': 'total_access'}).loc[:,["DATE","total_access"]]

bot = df.groupby(['DATE'], as_index=False).sum()
bot = bot.loc[:,["DATE","BOT"]]

# アウトプット
answer_data = pd.merge(total, bot, on=['DATE'],how='left').fillna(value=0)
answer_data = answer_data[ answer_data["BOT"]/answer_data["total_access"] <=0.5 ]
answer_data = answer_data.drop("BOT", axis=1)
answer_data = answer_data.values.tolist()

with open(dirname + '/data/accesslog_01.answer.csv', 'w') as f:
    writer = csv.writer(f, lineterminator = '\n')
    writer.writerows(answer_data)
