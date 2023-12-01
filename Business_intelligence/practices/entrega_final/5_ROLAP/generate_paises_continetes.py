import pandas as pd

# Cargar el archivo CSV
df = pd.read_csv('Metadata_Country_API_SP.POP.TOTL_DS2_en_csv_v2_6011311.csv')

# Extraer las columnas necesarias
continentes_paises = df[['Country Code', 'Region', 'TableName']]

# Limpiar y preparar los datos
continentes_paises = continentes_paises.dropna(subset=['Region'])
continentes_paises = continentes_paises.rename(columns={'TableName': 'Country Name'})

# Guardar el resultado en un nuevo archivo CSV
continentes_paises.to_csv('paises_continentes.csv', index=False)
