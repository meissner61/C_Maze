#include <stdio.h>
#include <stdlib.h>

void print4BitBinary(unsigned int n) {
    // Mask to ensure n is within 4 bits
    n = n & 0xF; // Equivalent to n % 16

    for (int i = 3; i >= 0; i--) {
        // Extract the bit at position i
        unsigned int bit = (n >> i) & 1;
        printf("%u", bit);
    }
    printf("\n"); // Newline for formatting
}



int main() 
{
    unsigned int n;



    // // Example: Display binary representations of numbers 0 to 15
    // for (n = 0; n < 16; n++) {
    //     printf("Decimal %2u: Binary ", n);
    //     print4BitBinary(n);
    // }




    printf("Testing Binary Print:\n\n");

    int X = 0b1100;
    //printf("X: %d\n", X);
    print4BitBinary(X);
    X = X >> 2;
        //printf("X: %d\n", X);
    print4BitBinary(X);
    X = X | (1 << 3);
    print4BitBinary(X);
    // int bit0 = X & 1;
    // int bit1 = (X >> 1) & 1;

    // printf("bit0: %d\n", bit0);
    // printf("bit1: %d\n", bit1);

    // X = X>>1;
    // // X = X>>1;
    // //     X = X>>1;
    

    // // X = X << 1;
    // //     X = X << 1;
    // //         X = X << 1;

    // printf("X: %d\n", X);

    // print4BitBinary(X);

    // printf("----------------:\n\n");

    // char buffer[33];
    // int i=5;
    // itoa(i,buffer, 2);

    // printf("Binary: %s: \n", buffer);


    return 0;
}
