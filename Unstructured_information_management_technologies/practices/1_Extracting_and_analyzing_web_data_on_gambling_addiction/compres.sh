#!/bin/bash

# Paso 1: Instalar las extensiones de Jupyter
#echo "Instalando extensiones de Jupyter..."
#pip install jupyter-contrib-nbextensions
##conda install -c conda-forge jupyter_contrib_nbextensions
#jupyter contrib nbextension install --user
#
## Paso 2: Habilitar la extensión de compresión (ejemplo: codefolding)
#echo "Habilitando la extensión de compresión..."
#jupyter nbextension enable codefolding/main

# Paso 3: Comprimir manualmente el archivo .ipynb
# nombre_del_cuaderno="tu_cuaderno.ipynb"
# nombre_comprimido="tu_cuaderno_comprimido.zip"
# echo "Comprimiendo el cuaderno $nombre_del_cuaderno..."
# zip -r "$nombre_comprimido" "$nombre_del_cuaderno"
# echo "El cuaderno se ha comprimido en $nombre_comprimido."

# Paso 4: Compartir el archivo comprimido
#echo "Ahora puedes compartir el archivo comprimido $nombre_comprimido con otros."


# Carpeta raíz donde buscar archivos .ipynb
carpeta_raiz=.

# Encuentra todos los archivos .ipynb mayores de 100 MB
archivos_grandes=$(find "$carpeta_raiz" -name "*.ipynb" -size +100M)

for archivo in $archivos_grandes; do
    # Obten el nombre del archivo sin la extensión
    nombre_base=$(basename "$archivo" .ipynb)

    # Comprime el archivo .ipynb en un archivo ZIP
    zip_file="${nombre_base}_comprimido.zip"
    zip -r "$zip_file" "$archivo"

    # Elimina el archivo original .ipynb
    rm "$archivo"

    echo "El archivo $archivo se ha comprimido en $zip_file y el original se ha eliminado."
done
