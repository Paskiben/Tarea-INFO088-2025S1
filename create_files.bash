#!/bin/bash

# Verificar si se proporcionó el número de directorios a crear
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Uso: $0 <cantidad_de_directorios>" "<directorio_destino>"
  exit 1
fi

# Número de directorios a crear
num_dirs=$1

# Directorio donde se guardaran los archivos
output_dir=$2

# Conjunto de extensiones posibles
extensions=(".txt" ".csv" ".cpp" ".c" ".json" ".xml" ".md")

# Función para generar un nombre aleatorio
random_name() {
  echo "$(tr -dc 'a-z0-9' </dev/urandom | head -c $((RANDOM % 11 + 10)))"
  # cat /dev/urandom | tr -dc 'a-z' | fold -w $((RANDOM % 11 + 10)) | head -n 1
}

mkdir -p $2

seq 1 $num_dirs | xargs -I {} touch "$output_dir/file_{}.txt"
