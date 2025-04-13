#include <stdio.h>

int main(){
    int mensaje_secreto[] = {116, 104, 101, 32, 103, 105, 102, 116, 32, 111,
        102, 32, 119, 111, 114, 100, 115, 32, 105, 115, 32, 116, 104, 101, 32,
        103, 105, 102, 116, 32, 111, 102, 32, 100, 101, 99, 101, 112, 116, 105,
        111, 110, 32, 97, 110, 100, 32, 105, 108, 108, 117, 115, 105, 111, 110};
    
    size_t length = sizeof(mensaje_secreto) / sizeof(int);
    char decoded[length];

    for (int i = 0; i < length; i++){
        decoded[i] = (char) mensaje_secreto[i];
    }

    printf("Mensaje decodificado: %s\n", decoded);

    return 0;
}

/*
El mensaje codificado es: the gift of words is the gift of deception and illusion
legth se calcula de esa manera, porque el sizeof de mensaje secreto retorna
el tamaño que ocupa en bytes en memoria, entonces para saber cuantos hay individualmente
se lo divide por el tamaño que ocupa un int.

Según cppreference:
tlrd: se usa size_t para guardar el tamaño de los objetos porque fue hecho para eso
puede guardar hasta el límite teorico de un objeto, de usar otro como unsigned int, puede fallar.

size_t is the unsigned integer type of the result of sizeof, offsetof and 
_Alignof(until C23)alignof(since C23), depending on the data model.

size_t can store the maximum size of a theoretically possible object of 
any type (including array).

size_t is commonly used for array indexing and loop counting. Programs that 
use other types, such as unsigned int, for array indexing may fail on, e.g. 
64-bit systems when the index exceeds UINT_MAX or if it relies on 32-bit 
modular arithmetic.
*/