#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Estructuras.h"

nodo_t* crear_nodo(uint32_t* arr, uint32_t longitud, uint8_t categoria) {
    nodo_t* nodo = malloc(sizeof(nodo_t));
    nodo->arreglo = malloc(longitud * sizeof(uint32_t));
    memcpy(nodo->arreglo, arr, longitud * sizeof(uint32_t));
    nodo->longitud = longitud;
    nodo->categoria = categoria;
    nodo->next = NULL;
    return nodo;
}

int main() {

	uint32_t arr1[] = {1,2,3};
	nodo_t* nodo1 = crear_nodo(arr1, 3, 1);

	uint32_t arr2[] = {1,2,3,4};
	nodo_t* nodo2 = crear_nodo(arr2, 4, 1);
	
	lista_t* listaPrueba = malloc(sizeof(lista_t));
	listaPrueba->head = nodo1;
	nodo1->next = nodo2;

	int cantInicial = cantidad_total_de_elementos(listaPrueba);

	printf("el res es: %d\n", cantInicial);

	free(nodo2->arreglo);
	free(nodo2);
	free(nodo1->arreglo);
	free(nodo1);
	free(listaPrueba);

	return 0;
}

