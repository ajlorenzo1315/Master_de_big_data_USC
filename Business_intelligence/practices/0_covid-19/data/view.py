import pandas as pd

# Ruta del archivo CSV
csv_path = 'owid-covid-data.csv'

# Cargar el archivo CSV en un DataFrame
df = pd.read_csv(csv_path)

# Mostrar las primeras filas del DataFrame
print("Las primeras filas del DataFrame:")
print(df.head())

# Lista de columnas específicas
columns = ['new_deaths', 'new_deaths_smoothed', 'total_cases_per_million', 
           'new_cases_per_million', 'new_cases_smoothed_per_million', 
           'total_deaths_per_million', 'new_deaths_per_million', 
           'new_deaths_smoothed_per_million', 'reproduction_rate', 
           'icu_patients', 'icu_patients_per_million', 'hosp_patients', 
           'hosp_patients_per_million', 'weekly_icu_admissions', 
           'weekly_icu_admissions_per_million', 'weekly_hosp_admissions', 
           'weekly_hosp_admissions_per_million', 'total_tests', 'new_tests', 
           'total_tests_per_thousand', 'new_tests_per_thousand', 
           'new_tests_smoothed', 'new_tests_smoothed_per_thousand', 
           'positive_rate', 'tests_per_case', 'tests_units', 
           'total_vaccinations', 'people_vaccinated', 'people_fully_vaccinated', 
           'total_boosters', 'new_vaccinations', 'new_vaccinations_smoothed', 
           'total_vaccinations_per_hundred', 'people_vaccinated_per_hundred', 
           'people_fully_vaccinated_per_hundred']

columns = ['location','new_cases_per_million','total_vaccinations', 'people_vaccinated', 'people_fully_vaccinated', 
           'total_boosters', 'new_vaccinations', 'new_vaccinations_smoothed', 
           'total_vaccinations_per_hundred', 'people_vaccinated_per_hundred', 
           'people_fully_vaccinated_per_hundred','new_people_vaccinated_smoothed']

columns = ['location','new_cases_per_million','total_vaccinations', 'people_vaccinated', 'people_fully_vaccinated', 
           'total_boosters', 'new_vaccinations']


# Mostrar los valores de la primera fila para las columnas especificadas
print("\nValores de la primera fila para las columnas especificadas:")
print(df.loc[417:417,columns])
