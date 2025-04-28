#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	assert(alternate_sum_4_using_c(8, 2, 5, 1) == 10);

	assert(alternate_sum_4_using_c_alternative(8, 2, 5, 1) == 10);

	assert(alternate_sum_8(1,2,5,1,1,4,3,2) == 1);

	uint32_t* destination = malloc(sizeof(uint32_t));
	product_2_f(destination, 5, 2.14);
	printf("destination: %d\n", *destination);
	assert(*destination == 10);
	free(destination);
	return 0;
}
