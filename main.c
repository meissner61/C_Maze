#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define WIDTH  11  // Maze width (odd number)
#define HEIGHT 7  // Maze height (odd number)

enum { WALL, PATH };



int maze[HEIGHT][WIDTH];

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
    maze[start_y][0] = PATH;                 // Entrance on the left edge
    maze[start_y][WIDTH - 1] = PATH;         // Exit on the right edge

    print_maze();
    return 0;
}

void init_maze() {
    for (int y = 0; y < HEIGHT; y++)
        for (int x = 0; x < WIDTH; x++)
            maze[y][x] = WALL;
}

void carve_passages(int x, int y) 
{
    printf("X: %d\n", x);
    printf("Y: %d\n", y);

    int dirs[] = { 0, 1, 2, 3 }; // 0: Up, 1: Right, 2: Down, 3: Left

    // Shuffle directions
    for (int i = 0; i < 4; i++) 
    {
        int r = rand() % 4;
        //printf("r=rand()%4 = %d\n", r);
        int temp = dirs[i];
        //printf("int temp = dirs[%d] = %d\n", i, dirs[i]);
        dirs[i] = dirs[r];
        //printf("dirs[i] = dirs[r] == %d = %d\n", dirs[i], dirs[r]);
        dirs[r] = temp;
        //printf("dirs[r] = temp = %d = %d\n", dirs[i], temp);
    }

    maze[y][x] = PATH;


    for (int i = 0; i < 4; i++) {
        int dx = 0, dy = 0;
        switch (dirs[i]) {
        case 0: dy = -2; break; // Up
        case 1: dx = 2; break; // Right
        case 2: dy = 2; break; // Down
        case 3: dx = -2; break; // Left
        }

        int nx = x + dx;
        int ny = y + dy;

        if (nx > 0 && nx < WIDTH - 1 && ny > 0 && ny < HEIGHT - 1 && maze[ny][nx] == WALL) {
            maze[y + dy / 2][x + dx / 2] = PATH; // Remove wall between cells
            carve_passages(nx, ny);
        }
    }
}

void print_maze() {
    for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {
            printf("%c", maze[y][x] == WALL ? '#' : ' ');
        }
        printf("\n");
    }
}