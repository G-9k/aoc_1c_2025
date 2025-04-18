/* main.c */
# include "funca.h"
# include "funcb.h"

int main(){
    a();
    b();
}

/*
Si editamos alguno de los archivos headers, con el makefile que
tenemos, se dará cuenta y volvera a recompilar los archivos fuente (.c)
que dependan del header modificado.
*/