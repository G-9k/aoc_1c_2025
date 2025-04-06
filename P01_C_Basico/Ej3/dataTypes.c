#include <stdio.h>
#include <stdint.h>

int main(){
    char c = 100;
    short s = -8712;
    int i = 123456;
    long l = 1234567890;

    int8_t i8 = -42;
    uint16_t u16 = 5169;
    int32_t i32 = -1234567;
    uint64_t u64 = -100;

    printf("char(%lu): %d \n", sizeof(c),c);
    printf("short(%lu): %d \n", sizeof(s),s);
    printf("int(%lu): %d \n", sizeof(i),i);
    printf("long(%lu): %ld \n", sizeof(l),l);

    printf("int8_t(%lu): %d \n", sizeof(i8),i8);
    printf("uint16_t(%lu): %d \n", sizeof(u16),u16);
    printf("int32_t(%lu): %d \n", sizeof(i32),i32);
    printf("uint64_t(%lu): %ld \n", sizeof(u64),u64);

    return 0;
}