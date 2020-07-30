import pandas as pd
from sqlalchemy import create_engine

user = "postgres"
pwd = "***********" # Replace with your password
host = "localhost"
port = "5432"
db = "postgres"

engine = create_engine("postgresql://" + user + ":" + pwd + 
                       "@" + host + ":" + port + "/" + db)

print('downloading vehicles data...')
vehicles = pd.read_csv("https://tf-assets-prod.s3.amazonaws.com/tf-curric/data-science/vehicles.csv")
print('loading vehicles data into db...')
vehicles.to_sql("vehicles", engine, index=False)

print('downloading houseprices data...')
houseprices = pd.read_csv("https://tf-assets-prod.s3.amazonaws.com/tf-curric/data-science/houseprices.csv")
print('loading houseprices data into db...')
houseprices.to_sql("houseprices", engine, index=False)
