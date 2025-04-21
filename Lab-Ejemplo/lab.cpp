#include <chrono> // Para medir el tiempo, Tutorial: https://www.geeksforgeeks.org/chrono-in-c/ documentation: https://cplusplus.com/reference/chrono/
#include <vector>
#include <algorithm> // Para ordenar un vector o Array.
#include <cstdio>

#define REP 10000 // Cantidad de veces a repetir la operacion REP=(1 * 10^5)
#define N (1 << 25) // Cantidad de elementos N = (2^25)
#define MAX (1 << 25) // Numero maximo a generar por el random MAX=(2^25)

int binarySearch(const std::vector<int> &A, int l, int r, int x){
    while (r < l) {
        int m = (l+r)/2;

        if (A.at(m) == x)
            return m;

        if (x < A.at(m))
            r = m-1; // busca en la mitad izquierda

        l = m+1; // busca en la mitad derecha }
    }

    return -1;
}

int main() {
    // ------------- CREACION DEL VECTOR ----------------->
    // Creamos el vector, agregamos los datos y ordenamos
    printf("Creando vector...\n");

    // Tomamos una marca de tiempo al iniciar la operacion a medir 
    std::chrono::high_resolution_clock::time_point start = std::chrono::high_resolution_clock::now();

    // Realizamos la operacion
    std::vector<int> vec(N);
    for (int& num : vec){
        num = rand()%MAX;
    }

    std::sort(vec.begin(), vec.end());

    // Tomamos una marca de tiempo cuando la operacion termino
    std::chrono::high_resolution_clock::time_point end = std::chrono::high_resolution_clock::now();

    // Calculamos duracion en segudos
    auto duration_creation = std::chrono::duration_cast<std::chrono::seconds>(end - start);

    // Imprimimos el tiempo de duracion
    printf("La creacion y ordenamiento del vector llevo %.4f segundos\n", static_cast<double>(duration_creation.count()));

    //<--------------------------------------------------

    // ------------- BUSQUEDA DE ELEMENTOS EN EL VECTOR ----------------->

    printf("Buscando elementos...\n");

    // Tomamos una marca de tiempo al iniciar la operacion a medir
    start = std::chrono::high_resolution_clock::now();

    // Realizamos la operacion a medir
    for (int i = 0 ; i < REP; i++){
        binarySearch(vec, 0, N-1, rand()%MAX);
    }

    // Tomamos una marca de tiempo cuando la operacion termino
    end = std::chrono::high_resolution_clock::now();

    // Calculamos duracion en nanosegundos
    auto duration_search = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);

    // Imprimimos el tiempo de duracion
    printf("La operacion de busqueda llevo en promedio %.4f nanosegundos\n", static_cast<double>(duration_search.count()) / REP);

    //<--------------------------------------------------

    return 0;
}
