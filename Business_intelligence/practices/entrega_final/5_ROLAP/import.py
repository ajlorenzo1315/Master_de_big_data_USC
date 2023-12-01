import pandas as pd
##Pivot population csv file to adapt it for importing into staging population table
# Load the data
df = pd.read_csv('API_SP.POP.TOTL_DS2_en_csv_v2_6011311.csv')
# List of columns to keep as identifier variables
id_vars = ["Country Name", "Country Code"]
# List of columns to unpivot
value_vars = [str(year) for year in range(1960, 2023)]
# Melt the dataframe to go from wide to long format
df_long = df.melt(id_vars=id_vars, value_vars=value_vars, var_name='Year', value_name='Population')
# Convert Year to a numerical value
df_long.dropna(subset=['Population'],inplace=True)
df_long['Population'] = df_long['Population'].astype(int,errors='ignore')
df_long['Year'] = df_long['Year'].astype(int,errors='ignore')
# Save the transformed data to a new CSV file
df_long.to_csv('population.csv', index=False)
