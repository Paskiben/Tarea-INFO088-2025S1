.PHONY = all clean

# Nombre del archivo de salida
TARGET = program

# Compilador
CXX = g++

# Opciones de compilación
CXXFLAGS = std=c++23 -Ofast -Wall -Wextra -Wconversion -Wdouble-promotion -Wduplicated-cond -Wfatal-errors -Wfloat-equal -Wformat=2 -Wlogical-op -Wpedantic -Wshadow -Wundef -Wno-unused-parameter -Wno-unused-result

# Archivos fuente
SOURCES = lab.cpp

# Regla por defecto
all: clean $(TARGET)

# Regla para compilar el ejecutable
$(TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SOURCES)

# Regla para limpiar archivos generados
clean:
	@echo " [CLN] Removing binary files"
	rm -f $(TARGET)
