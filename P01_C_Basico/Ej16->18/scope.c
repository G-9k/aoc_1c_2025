/*


# include <stdio.h>
# define FELIZ 0
# define TRISTE 1

void ser_feliz(int estado);
void print_estado(int estado);

int main(){
    int estado = TRISTE; // automatic duration. Block scope
    ser_feliz(estado);
    print_estado(estado); // qué imprime?
}

void ser_feliz(int estado){
    estado = FELIZ;
}

void print_estado(int estado){
    printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
}


Este programa imprime estoy triste, porque la función ser feliz
cambia el el valor pasado el cual es una copia, y eso no cambia el
estado local dentro de int main()

*/

/*

# include <stdio.h>
# define FELIZ 0
# define TRISTE 1

int estado = TRISTE; // static duration. File scope
void ser_feliz();
void print_estado();

int main(){
    print_estado();
    ser_feliz();
    print_estado(); // qué imprime?
}

void ser_feliz(){
    estado = FELIZ;
}

void print_estado(){
    printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
}

*/

/* Aca a ser feliz no se le pasa nada por parametro, directamente accede
a la variable global estado definida como triste, y la cambia a feliz.
Por eso en todas las funciones no se pasa a estado por parametro, ya que todas
las funciones pueden acceder a variables globales con scope de archivo.
*/

# include <stdio.h>
# define FELIZ 0
# define TRISTE 1

int estado = TRISTE; // static duration. File scope
void alcoholizar();
void print_estado();

int main(){
    print_estado();
    alcoholizar();
    print_estado();
    alcoholizar();alcoholizar();alcoholizar();
    print_estado(); // que imprime?
}

void alcoholizar(){
    static int cantidad = 0; // static duration. block scope
        cantidad++;
    if(cantidad < 3){
        estado = FELIZ;
    }else{
        estado = TRISTE;
    }
}

void print_estado(){
    printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
}

/* Parece ser que static hace que la variable sea creada y definida una
sola vez en 0, luego recuerda su valor cuando es modificada y la función
usada mas veces.
*/