#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

void displayArray(int *array, int length){
	printf("[");
	printf("%d", array[0]);
	for(int i = 1; i < length; i++){
		printf(", %d", array[i]);
	}
	printf("]\n");
}
int *randArray(int* newArray, int n){
	for(int i = 0; i < n; i++){
		//printf("%d\n", rand() % 10000);
		newArray[i] = rand() % 10000;
	}
	return newArray;
}
void swap(int *array, int index1, int index2){
	int tmp = array[index1];
	array[index1] = array[index2];
	array[index2] = tmp;
}

int *combSort(int *newArray, const int length){
	bool isSwapped = true;
	int h = length * 10 / 13;
	while(h > 1 || isSwapped){
		if(h > 1){
			h = h * 10 / 13;
		}
		int i = 0;
		isSwapped = false;
		while(true){
			if(newArray[i] > newArray[i + h]){
				swap(newArray, i, i+h);
				isSwapped = true;
			}
			i++;
			if(i+h >= length) break;
		}
	}
	return newArray;
}

int main(void){
	const int arrayLength = 100;
	//printf("hello\n");
	int *array = malloc(sizeof(int) * arrayLength);
	//int *sortedArray = malloc(sizeof(int) * arrayLength);
	array = randArray(array, arrayLength);
	//printf("hello\n");
	displayArray(array, arrayLength);
	//printf("hello\n");
	//*sortedArray = combSort(array, arrayLength);
	combSort(array, arrayLength);
	printf("hello\n");
	displayArray(array, arrayLength);
	//printf("hello\n");
	return 0;
}
