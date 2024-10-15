
#include <stdio.h>


void print4BitBinary(unsigned int n) 
{
    // Mask to ensure n is within 4 bits
    n = n & 0xF; // Equivalent to n % 16

    for (int i = 3; i >= 0; i--) {
        // Extract the bit at position i
        unsigned int bit = (n >> i) & 1;
        printf("%u", bit);
    }
    //printf("\n"); // Newline for formatting
}

int lfsr_4(int num4Bit)
{
    int start = 0b1001;
    //LSB
    int bit0;
    //LSB<<1
    int bit1;
    int newBit;

    int lfsr = start;
    int output;

    do
    {
        print4BitBinary(lfsr);
        //get the output
        output = lfsr & 1;
        printf("  |  output: %d   ", output);

        //grab the first 2 LSB
        bit0 = lfsr & 1;
        bit1 = (lfsr >> 1) & 1;
        newBit = bit0 ^ bit1;

        printf("LSB: bit0: %d, bit1: %d\n",bit0, bit1);

        //shift right
        lfsr = lfsr >> 1;

        //insert new bit into the MSB 4th bit
        lfsr = lfsr | (newBit << 3);


    }while(lfsr != start);

}



int main()
{

    lfsr_4(0);

    return 0;
}