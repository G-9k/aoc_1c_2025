#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"

int main() {
	
	char* str1 = "";
	char* str2 = "abd";

	assert(strCmp(str1, str2) == 1);
	//assert(strLen(str1) == 0);

	char* cloneStr2 = strClone(str2);
	printf("%s \n", cloneStr2);
	free(cloneStr2);

	return 0;
}
