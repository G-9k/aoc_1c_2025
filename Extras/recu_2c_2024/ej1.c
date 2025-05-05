#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ej1.h"

/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - es_indice_ordenado
 */
bool EJERCICIO_1A_HECHO = true;

/**
 * Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - contarCombustibleAsignado
 */
bool EJERCICIO_1B_HECHO = true;

/**
 * Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - modificarUnidad
 */
bool EJERCICIO_1C_HECHO = true;

/**
 * OPCIONAL: implementar en C
 */
void optimizar(mapa_t mapa, attackunit_t* compartida, uint32_t (*fun_hash)(attackunit_t*)) {
    uint32_t hashActual;
    uint32_t hashCompartido = fun_hash(compartida);
    
    for(int i = 0; i < 255; i++){
        for(int j = 0; j < 255; j++){
            attackunit_t *unidadActual = mapa[i][j];
            if(unidadActual != NULL && unidadActual != compartida) hashActual = fun_hash(unidadActual);

            if(hashActual == hashCompartido){
                compartida->references++;
                unidadActual->references--;
                mapa[i][j] = compartida;
                hashActual = 0;
                if(unidadActual->references == 0) free(unidadActual);
            }

        }
    }
}

/**
 * OPCIONAL: implementar en C
 */
uint32_t contarCombustibleAsignado(mapa_t mapa, uint16_t (*fun_combustible)(char*)) {
    uint32_t res = 0;
    attackunit_t* unidadActual;
    for(int i = 0; i < 255; i++){
        for(int j = 0; j < 255; j++){
            unidadActual = mapa[i][j];
            if(unidadActual != NULL){
                res -= fun_combustible(unidadActual->clase);
                res += unidadActual->combustible;
            }
        }
    }
    return res;
}

/**
 * OPCIONAL: implementar en C
 */
void modificarUnidad(mapa_t mapa, uint8_t x, uint8_t y, void (*fun_modificar)(attackunit_t*)) {
    attackunit_t *unidadAModificar;
    unidadAModificar = mapa[x][y];

    if(unidadAModificar != NULL){
        if(unidadAModificar->references > 1){
            attackunit_t *nuevaUnidad = malloc(sizeof(attackunit_t));
            *nuevaUnidad = *unidadAModificar;
            fun_modificar(nuevaUnidad);
            nuevaUnidad->references = 1;
            unidadAModificar->references--;
            mapa[x][y] = nuevaUnidad;
        }
        else fun_modificar(unidadAModificar);
    }
}
