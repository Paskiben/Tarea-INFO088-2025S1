# Phony targets
.PHONY: all clean

# Definir compilador y flags
CXX = g++
CXXFLAGS = -std=c++23 -Ofast -Wall -Wextra -Wconversion -Wdouble-promotion -Wduplicated-cond -Wfatal-errors -Wfloat-equal -Wformat=2 -Wlogical-op -Wpedantic -Wshadow -Wundef -Wno-unused-parameter -I$(INC_DIR) #-g3 for GNU debugger

# Directorios
SRC_DIR = src
INC_DIR = include
OUT_DIR = out
BIN_DIR = bin

# Archivos fuente
MAIN = $(SRC_DIR)/main.cpp
SOURCES = $(SRC_DIR)/vector.cpp $(SRC_DIR)/experimentacion.cpp

# Archivos objeto
OBJECTS = $(OUT_DIR)/vector.o $(OUT_DIR)/experimentacion.o

# Ejecutable
EXECUTABLE = $(BIN_DIR)/file_experiments

# Regla por defecto: compilar el ejecutable
all: $(EXECUTABLE)

# Compilar el ejecutable enlazando los objetos
$(EXECUTABLE): $(OBJECTS) | $(BIN_DIR)
	$(CXX) $(OBJECTS) -o $@ $(MAIN) -I$(INC_DIR)

# Regla para compilar cada archivo .cpp en su correspondiente .o
$(OUT_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OUT_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Crear el directorio de binarios si no existe
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Crear el directorio de archivos objeto si no existe
$(OUT_DIR):
	mkdir -p $(OUT_DIR)

# Limpiar los archivos generados
clean:
	rm -rf $(OUT_DIR) $(BIN_DIR)

