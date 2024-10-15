#include <stdio.h>

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

int main() {
    unsigned int n;

    // Example: Display binary representations of numbers 0 to 15
    for (n = 0; n < 16; n++) {
        printf("Decimal %2u: Binary ", n);
        print4BitBinary(n);
    }

    return 0;
}
