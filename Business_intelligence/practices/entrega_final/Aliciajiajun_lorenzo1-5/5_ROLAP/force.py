import pandas as pd

# Function to load and transform the data
def transform_labor_force_data(file_path, output_file_path):
    try:
        # Load the data, assuming the first row is the header
        df = pd.read_csv(file_path, header=0, skiprows=4)  # Adjust skiprows as needed

        # List of columns to keep as identifier variables
        id_vars = ["Country Name", "Country Code"]

        # List of columns to unpivot (years from 1960 to 2022)
        value_vars = [str(year) for year in range(1960, 2023)]

        # Melt the dataframe to go from wide to long format
        df_long = df.melt(id_vars=id_vars, value_vars=value_vars, var_name='Year', value_name='Labor force')

        # Drop rows with missing 'Labor force' data
        df_long.dropna(subset=['Labor force'], inplace=True)

        # Convert 'Year' and 'Labor force' to integers, ignoring errors
        df_long['Year'] = pd.to_numeric(df_long['Year'], errors='coerce').astype('Int64')
        df_long['Labor force'] = pd.to_numeric(df_long['Labor force'], errors='coerce').astype('Int64')

        # Save the transformed data to a new CSV file
        df_long.to_csv(output_file_path, index=False)

        print(f"Data successfully transformed and saved to {output_file_path}")
    except Exception as e:
        print(f"An error occurred: {e}")

# Path to your CSV file
input_file_path = 'API_SL.TLF.TOTL.IN_DS2_en_csv_v2_5996631.csv'

# Path to the output file
output_file_path = 'Labor_force_transformed.csv'

# Call the function
transform_labor_force_data(input_file_path, output_file_path)