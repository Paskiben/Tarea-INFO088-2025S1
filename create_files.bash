#!/bin/bash

# Verificar argumentos
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Uso: $0 <cantidad_de_directorios> <cantidad_de_archivos> <directorio_destino>"
	exit 1
fi

max_dirs=$1
max_files=$2
output_dir=$3

# Contadores globales
dirs_creados=0
archivos_creados=0

files_per_dir=$((max_files / max_dirs))

# Conjunto de extensiones posibles
extensions=(".txt" ".csv" ".cpp" ".c" ".json" ".xml" ".md" ".rs" ".py" ".js" ".lua")

rm -rf "$output_dir"
mkdir -p "$output_dir"

# Función para generar un nombre aleatorio
random_name() {
	tr -dc 'a-z0-9' </dev/urandom | head -c $((RANDOM % 11 + 10))
}

# Función recursiva para crear árbol
create_tree() {
	local dirs_to_process=("$1")
	local dir_count=1
	local file_count=0

	while [ ${#dirs_to_process[@]} -gt 0 ] && { [ $dir_count -lt $max_dirs ] || [ $file_count -lt $max_files ]; }; do
		local next_level_dirs=()
		for current_dir in "${dirs_to_process[@]}"; do
			# Calcular cuántos subdirectorios y archivos quedan por crear
			local remaining_dirs=$((max_dirs - dir_count))
			local remaining_files=$((max_files - file_count))
			if [ $remaining_dirs -le 0 ] && [ $remaining_files -le 0 ]; then
				continue
			fi

			# Elegir aleatoriamente cuántos subdirectorios y archivos crear en este nivel (máximo 10)
			local max_random_dirs=10
			local max_random_files=1
			local subdirs=0
			local files=0

			if [ $remaining_dirs -gt 0 ]; then
				local max_subdirs=$((remaining_dirs < max_random_dirs ? remaining_dirs : max_random_dirs))
				subdirs=$((RANDOM % (max_subdirs + 1)))
			fi
			if [ $remaining_files -gt 0 ]; then
				files=$(((RANDOM % (max_random_files * 3 + 1)) - max_random_files))
				files=$((files + files_per_dir))
				if [ $files -gt $remaining_files ]; then
					files=$remaining_files
				fi
				if [ $files -le 0 ]; then
					files=1
				fi
			fi

			# Crear archivos en el directorio actual
			ext_count=${#extensions[@]}  # Calcular una sola vez

			for ((i=1; i<=files; i++)); do
				((++file_count))
				extension="${extensions[RANDOM % ext_count]}"

				touch "$current_dir/file_$file_count$extension"

				((file_count >= max_files)) && break
			done

			# Crear subdirectorios y agregarlos a la lista del siguiente nivel
			for ((i=1; i<=subdirs; i++)); do
				((++dir_count))
				subdir="$current_dir/dir_$dir_count"
				mkdir -p "$subdir"
				next_level_dirs+=("$subdir")
				if [ $dir_count -ge $max_dirs ]; then
					break
				fi
			done
		done
		dirs_to_process=("${next_level_dirs[@]}")
	done
}

create_tree "$output_dir"
