#!/bin/bash

# Verificar que se proporcionen dos argumentos
if [ $# -ne 2 ]; then
  echo "Uso: $0 <directorio_entrada> <directorio_destino>"
  exit 1
fi

# Directorio de entrada y directorio de destino
directorio_entrada="$1"
directorio_destino="$2"

# Verificar si el directorio de entrada existe
if [ ! -d "$directorio_entrada" ]; then
  echo "El directorio de entrada '$directorio_entrada' no existe."
  exit 1
fi

# Verificar si el directorio de destino existe, si no, crearlo
if [ ! -d "$directorio_destino" ]; then
  mkdir -p "$directorio_destino"
fi

# Copiar archivos de la carpeta de entrada al directorio de destino
for archivo in "$directorio_entrada"/*; do
  if [ -f "$archivo" ]; then
    # Extraer el nombre del archivo sin la ruta
    nombre_archivo=$(basename "$archivo")
    # Crear la ruta completa para el archivo de destino
    ruta_destino="$directorio_destino/$nombre_archivo"
    # Copiar el archivo
    cp "$archivo" "$ruta_destino"
    echo "Archivo copiado: $nombre_archivo a $ruta_destino"
  fi
done

echo "Proceso completado."
