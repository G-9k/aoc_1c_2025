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


	return 0;
}
