#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define WIDTH  25  // Maze width (odd number)
#define HEIGHT 25  // Maze height (odd number)

enum { WALL, PATH };



int maze[WIDTH][HEIGHT];

void init_maze();
void carve_passages(int x, int y);
void print_maze();

int main() 
{
    srand(time(NULL));
    init_maze();

    // Start carving from a random edge cell
    int start_x = 1;
    int start_y = (rand() % (HEIGHT / 2)) * 2 + 1;  // Ensure odd index

    printf("\nStartX and Y: %d, %d\n", start_x, start_y);



    carve_passages(start_x, start_y);

    //print_maze();



    // Set entrance and exit
    maze[0][start_y] = PATH;                 // Entrance on the left edge
    maze[WIDTH - 1][start_y] = PATH;         // Exit on the right edge

    print_maze();
    return 0;
}

void init_maze() {
    for (int y = 0; y < HEIGHT; y++)
        for (int x = 0; x < WIDTH; x++)
            maze[x][y] = WALL;
}

void carve_passages(int x, int y) 
{
    //printf("X: %d\n", x);
    //printf("Y: %d\n", y);

    int dirs[] = { 0, 1, 2, 3 }; // 0: Up, 1: Right, 2: Down, 3: Left

    // Shuffle directions
    for (int i = 0; i < 4; i++) 
    {
        int r = rand() % 4;
        int temp = dirs[i];
        dirs[i] = dirs[r];
        dirs[r] = temp;

        //dirs[i] = rand() % 3;

        //printf("dirs[%d] = %d\n", i, dirs[i]);
    }

    maze[x][y] = PATH;

    // for(int i = 0; i < 4; i++)
    // {
    //     printf("ENDING dirs[%d] = %d\n", i, dirs[i]);
    // }

    //printf(" ENDING 0 dirs[%d] = %d\n", 0, dirs[0]);

    for (int i = 0; i < 4; i++) 
    {
        int dx = 0, dy = 0;
        switch (dirs[i]) 
        {
            case 0: 
            {
                dy = -2; 
                //printf("case 0 selected!\n");
                break; // Up
            }
            case 1: 
            {
                dx = 2; 
                //printf("case 1 selected!\n");
                break; // Right
            }
            case 2: 
            {
                dy = 2; 
                //printf("case 2 selected!\n");
                break; // Down
            }
            case 3: 
            {
                dx = -2; 
                //printf("case 3 selected!\n");
                break; // Left
            }
        }
        //printf("Before next X, X = %d\n", x);
        //printf("Before next Y, Y = %d\n", y);
        int nx = x + dx;
        int ny = y + dy;

        //printf("next X: %d\n", nx);
        //printf("next Y: %d\n", ny);

        if (nx > 0 && nx < WIDTH - 1 && ny > 0 && ny < HEIGHT - 1 && maze[nx][ny] == WALL) {
            maze[x + dx / 2][y + dy / 2] = PATH; // Remove wall between cells
            carve_passages(nx, ny);
        }
    }
}

void print_maze() {
    for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {
            printf("%c", maze[x][y] == WALL ? '#' : ' ');
        }
        printf("\n");
    }
}