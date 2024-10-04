#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define WIDTH  20  // Width of the maze
#define HEIGHT 20  // Height of the maze

char my_maze[WIDTH * HEIGHT];

void GeneratePath(char maze[])
{
    for(int i = 0; i < WIDTH * HEIGHT; i++)
    {
        maze[i] = '#';
    }

    //which side to start the path on
    int side; //0 = left and right, 1 = top and bottom
    srand(time(NULL));  
    side = rand() % 2; //results 0 or 1  
    //printf("%d",side);  

    if(side == 0)// left and right side is exit
    {
        int x = 0;
        int endx = WIDTH-1;
        int y = rand() % HEIGHT;
        int endy = rand() % HEIGHT;

        maze[y*WIDTH+x] = ' ';
        maze[endy * WIDTH + endx] = ' ';

        printf("X: %d\n", x);
        printf("Y: %d\n", y);
        printf("EndX: %d\n", endx);
        printf("EndY: %d\n", endy);
    }
    else
    {
        int y = 0;
        int endy = HEIGHT - 1;
        int x = rand()%WIDTH;
        int endx = rand() % WIDTH;

        maze[y * WIDTH + x] = ' ';
        maze[endy * WIDTH + endx] = ' ';
    }

    

}

void PrintMaze(char maze[])
{
    for(int y = 0; y < HEIGHT; y++)
    {
        for(int x = 0; x < WIDTH; x++)
        {
            printf("%c",my_maze[y*WIDTH + x]);
        }
        printf("\n");
    }
}

// Function to generate a basic guaranteed path from entrance to exit
void generatePath(char maze[HEIGHT][WIDTH]) 
{
    // Initialize the grid with walls
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            maze[i][j] = '#';
        }
    }

    // Carve a simple path from the top-left to the bottom-right corner
    int x = 1, y = 0;  // Start just after the border
    maze[y][x] = '.';  // Entrance

    while (x < WIDTH - 2 || y < HEIGHT - 2) {
        // Randomly choose to move either right or down to carve a path
        if ((rand() % 2 == 0 && x < WIDTH - 2) || y == HEIGHT - 2) {
            x++; // Move right
        }
        else {
            y++; // Move down
        }
        maze[y][x] = '.';
    }

    // Ensure exit is open
    maze[HEIGHT - 2][WIDTH - 1] = '.';  // Exit
}

// Add some random walls to the maze without blocking the guaranteed path
void addRandomWalls(char maze[HEIGHT][WIDTH]) {
    for (int i = 1; i < HEIGHT - 1; i++) {
        for (int j = 1; j < WIDTH - 1; j++) {
            if (maze[i][j] == '#' && rand() % 3 == 0) {
                maze[i][j] = '.';  // Randomly carve out some spaces
            }
        }
    }
}

void printMaze(char maze[HEIGHT][WIDTH]) 
{
    printf("Printing mazE!\n");
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            printf("%c", maze[i][j]);
        }
        printf("\n");
    }
}

int main() {
    srand(time(NULL));  // Seed the random number generator

    char maze[HEIGHT][WIDTH];
    //printf("Test hello!\n");

    //GeneratePath(my_maze);
    //PrintMaze(my_maze);

     generatePath(maze);    // Generate the guaranteed path
     //printMaze(maze);       // Display the maze

     addRandomWalls(maze);  // Add random walls around the path
     printMaze(maze);       // Display the maze

    return 0;
}
