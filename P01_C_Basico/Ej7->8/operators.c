#include <stdio.h>
#include <stdint.h>

int main(){

    int a,b,c,d;
    a = 5, b = 3, c = 2, d = 1;
    printf("primero: %i %i %i %i\n", a, b, c, d);

    int segundo = a + b * c / d;    //da 11, parece seguir las reglas de
    printf("segundo: %i \n", segundo);// la arimetica, no como smalltalk

    int tercero = a % b;            //da el resto de la división entera
    printf("tercero: %i \n", tercero);
    
    int cuartoA, cuartoB;
    cuartoA = a == b;
    cuartoB = a != b;
    printf("cuarto a: %i b: %i \n", cuartoA, cuartoB);

    int quintoA, quintoB;
    quintoA = a & b;    // and bitwise
    quintoB = a | b;    // or bitwise
    printf("quinto a: %i b: %i \n", quintoA, quintoB);

    int sexto = ~a;
    size_t tamaño = sizeof(int);
    printf("sexto: %i tamaño: %li \n", sexto, tamaño);
    /*notese que un int ocupa 4 bytes, negar a 5 sería
    5(base10) = 0000 0000 0000 0101
    -6(base10) = 1111 1111 1111 1010
    eso es porque int utiliza representación complemento a 2.*/

    int septimoA, septimoB;
    septimoA = a && b;
    septimoB = a || b;
    printf("septimo a: %x b: %x \n", septimoA, septimoB);
    /*esto es and y or lógico, como 0 es false y
    cualquier cosa distinta de 0 es true, estoy haciendo:
    true and true
    true or true
    */

    int octavo = a << 1;    // shl (no se si es aritmético o lógico)
    printf("octavo: %i \n", octavo);

    int noveno = a >> 1;    // shr (no se si es aritmético o lógico)
    printf("noveno: %i \n", noveno);

    int e = -4;
    int shrTest = e >> 1;
    printf("shrTest: %i \n", shrTest);  //dio -2, es aritmético

    int decimoA, decimoB, decimoC, decimoD, decimoE;
    decimoA = a += b;   //esto ademas de sumar a y b, reasigna el resultado a 'a', luego a decimoA
    decimoB = a -= b;   //para este punto, a vale 8, entonces 8-3=5
    decimoC = a *= b;   //5*3=15
    decimoD = a /= b;   //15/3=5
    decimoE = a %= b;   //5%3=2
    printf("decimo a: %i b: %i c: %i d: %i e: %i \n", decimoA, decimoB, decimoC, decimoD, decimoE);

    //Ejercicio 8
    int loopA = 0;
    int loopB = 0;
    for(int i = 0; i < 5; i++){
        printf("a: %i \n", loopA++);
        printf("b: %i \n", ++loopB);
    }

    /*notar que loopA++ devuelve el valor de loopA antes de incrementarlo,
    mientras que ++loopB devuelve el valor de loopB después de incrementarlo.
    por eso, loopA empieza en 0 y termina en 4, mientras que loopB empieza 
    en 1 y termina en 5.*/

    return 0;
}

/*usar %x imprime en hexadecimal, por ejemplo, si queres imprimir
10, te va a salir 'a'.
*/