#include "Memoria.h"

uint32_t strLenC(char* a){
    uint32_t lengA = 0;
    while(a[lengA] != 0){
        lengA++;
    }
    return lengA;
}

int32_t strCmpC(char *a, char *b){
    uint32_t lengA = strLenC(a);
    uint32_t lengB = strLenC(b);
    uint32_t minLen = 0;

    if(lengA < lengB) minLen = lengA;
    else minLen = lengB;

    for(int i = 0; i < minLen; i++){
        if(a[i] < b[i]) return 1;
        else if(a[i] > b[i]) return -1;
    }

    if(lengA == lengB) return 0;
    else if(lengA > lengB) return -1;
    else return 1;
}


/* Pueden programar alguna rutina auxiliar acá */
