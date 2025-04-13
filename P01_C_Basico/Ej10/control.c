#include <stdio.h>

int main() {
    int i = 10;
    while(i--){
        printf("i = %d\n",i); // imprime o no el 0?
    }

    for(int i = 9; i >= 0; i--){
        printf("i = %d\n",i);
    }

    return 0;
}

/*operador de postdecremento, dentro del while, el valor es 10
inicialmente, entra dentro del cuerpo del while porque aun no es 0
y al entrar se decrementa e imprime 9.
Por lo tanto, cuando llega a 1, entra al cuerpo del while y luego lo decrementa
imprimiendo asi 0.
*/