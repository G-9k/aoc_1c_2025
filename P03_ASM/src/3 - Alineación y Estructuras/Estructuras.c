#include "Estructuras.h"

extern uint32_t cantidad_total_de_elementos_enC(lista_t *lista){

    int res = 0;
    nodo_t* sig = lista->head;

    while(sig != NULL){
        res += sig->longitud;
        sig = sig->next;
        
    }
    return res;

}

/* Pueden programar alguna rutina auxiliar acá */
