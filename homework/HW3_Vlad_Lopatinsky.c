#include <stdio.h>

void InitArray(int arr[3][5])
{
    for(int y = 0; y < 3; y++)
    {
        for(int x = 0; x < 5; x++)
        {
            int num = y * 5;
            arr[y][x] = num + x + 1;
        }
    }
}

int *ArrayAddress(int row, int col, int ncols);


int main()
{

    int arr[3][5];

    // for(int y = 0; y < 3; y++)
    // {
    //     for(int x = 0; x < 5; x++)
    //     {
    //         int num = y * 5;
    //         arr[y][x] = num + x + 1;
    //     }
    // }

    for(int y = 0; y < 3; y++)
    {
        for(int x = 0; x < 5; x++)
        {
            printf("arr:[%d][%d]: %d\n", y, x, arr[y][x]);
        }
    }


    int y, x =0;


    printf("Enter y: ");
    scanf("%d", &y);
    printf("Enter x: ");
    scanf("%d", &x);


    printf("arr[%d][%d]: %d\nAdress: %p", y, x, arr[y][x], &arr[y][x]);




    return 0;
}