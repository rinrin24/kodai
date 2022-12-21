#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define CELL_NUMBER 3

void initializeGrid(char *grid){
	bool usedNumber[CELL_NUMBER * CELL_NUMBER] = {false};
	for(int i = 0; i < CELL_NUMBER; i++){
		for(int j = 0; j < CELL_NUMBER; j++){
			while(true){
				int tmp = rand() % (int)pow(CELL_NUMBER, 2);
				if(usedNumber[tmp]) continue;
				sprintf(&grid[i * CELL_NUMBER + j], "%X", tmp);
				usedNumber[tmp] = true;
				break;
			}
		}
	}
}
void displayGrid(char grid[][CELL_NUMBER]){
	for(int i = 0; i < CELL_NUMBER; i++){
		for(int j = 0; j < CELL_NUMBER; j++){
			if(grid[i][j] == '0') { printf(" "); continue; }
			printf("%c", grid[i][j]);
		}
		printf("\n");
	}
}
bool isSolved(char *grid){
	if(grid[(int)pow(CELL_NUMBER, 2) - 1] != '0') return false;
	for(int i = 0; i < (pow(CELL_NUMBER, 2) - 1 - 1); i++){
		if(grid[i] > grid[i+1]) return false;
	}
	return true;
}
int findCell(char *grid, int number){
	char searchNumber;
	sprintf(&searchNumber, "%X", number);
	for(int i = 0; i < CELL_NUMBER; i++){
		for(int j = 0; j < CELL_NUMBER; j++){
			if(grid[i * CELL_NUMBER + j] == searchNumber) return (i * CELL_NUMBER + j);
		}
	}
}
void moveLeft(char *grid){
	//空欄のセルを探す
	const int spaceCell = findCell(grid, 0);
	const int column = spaceCell % CELL_NUMBER;
	const int row = spaceCell / CELL_NUMBER;
	printf("%d\n", spaceCell);
	//右端なら
	if(column == (CELL_NUMBER - 1)) return;

	grid[row * CELL_NUMBER + column] = grid[row * CELL_NUMBER + column + 1];
	grid[row * CELL_NUMBER + column + 1] = '0';
}
void moveUp(char *grid){
	//空欄のセルを探す
	const int spaceCell = findCell(grid, 0);
	const int column = spaceCell % CELL_NUMBER;
	const int row = spaceCell / CELL_NUMBER;
	//一番下なら
	if(row == CELL_NUMBER - 1) return;

	grid[row * CELL_NUMBER + column] = grid[(row + 1) * CELL_NUMBER + column];
	grid[(row + 1) * CELL_NUMBER + column] = '0';
}
void moveRight(char *grid){
	//空欄のセルを探す
	const int spaceCell = findCell(grid, 0);
	const int column = spaceCell % CELL_NUMBER;
	const int row = spaceCell / CELL_NUMBER;
	//左端なら
	if(column == 0) return;
	
	grid[row * CELL_NUMBER + column] = grid[row * CELL_NUMBER + column - 1];
	grid[row * CELL_NUMBER + column - 1] = '0';
}
void moveDown(char *grid){
	//空欄のセルを探す
	const int spaceCell = findCell(grid, 0);
	const int column = spaceCell % CELL_NUMBER;
	const int row = spaceCell / CELL_NUMBER;
	//一番上なら
	if(row == 0) return;

	grid[row * CELL_NUMBER + column] = grid[(row - 1) * CELL_NUMBER + column];
	grid[(row - 1) * CELL_NUMBER + column] = '0';
}

int main(void){
	srand((unsigned int)time(NULL));
	char grid[CELL_NUMBER][CELL_NUMBER];
	initializeGrid(*grid);
	displayGrid(grid);
	int numberOfMovement = 0;
	int beginTime = clock();
	while(true){
		char input;
		scanf("%c", &input);
		switch (input)
		{
		case 'a':
			moveLeft(*grid);
			numberOfMovement++;
			break;
		case 'w':
			moveUp(*grid);
			numberOfMovement++;
			break;
		case 'd':
			moveRight(*grid);
			numberOfMovement++;
			break;
		case 's':
			moveDown(*grid);
			numberOfMovement++;
			break;
		default:
			continue;
			break;
		}
		displayGrid(grid);
		if(isSolved(*grid)) break;
	}
	int endTime = clock();
	printf("----------\n");
	printf("Congratulations!\n");
	printf("You have solved the puzzle!\n\n");
	printf("Result\n");
	printf("----------\n");
	printf("Level: %d\n", CELL_NUMBER);
	printf("Number of Movement: %d\n", numberOfMovement);
	printf("Time: %dsec\n", (endTime - beginTime) / 1000);
	return 0;
}