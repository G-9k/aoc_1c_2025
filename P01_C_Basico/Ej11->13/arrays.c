#include <stdio.h>
#include <stdlib.h>

int main(){
    int array[4] = {1, 2, 3, 4};
    size_t size = sizeof(array) / sizeof(array[0]);
    int veces = 2;

    for(int i = 0; i < veces; i++){
        int firstElement = array[0];
        for(size_t i = 0; i < size - 1; i++){
            array[i] = array[i + 1];
        }
        array[size - 1] = firstElement;
    }
    for(size_t i = 0; i < size; i++){
        printf("%d ", array[i]);
    }
    printf("\n");


    int arrayDados[6] = {0};
    int newRandom;
    for(int i = 0; i < 60000000; i++){
        newRandom = rand() % 6;
        // el resto es de 0 a 5 (esto lo podemos usar como los indices
        // del dado, siendo que cada valor en realidad se le debería sumar 1)
        arrayDados[newRandom]++;
    }
    for(int i = 0; i < 6; i++){
        printf("Cantidad de %d: %d \n", (i+1), arrayDados[i]);
    }
    printf("\n");
}

