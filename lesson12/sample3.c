#include <stdio.h>
#include <stdbool.h>

int progression[31] = { -1 };

int fibonacci(int number){
	if(number >= 31) return fibonacci(number - 1) + fibonacci(number - 2); 
	if(progression[number] != -1) return progression[number];
	progression[number] = fibonacci(number - 1) + fibonacci(number - 2);
	return progression[number];
}
int main(void){
	for(int i = 0; i < 31; i++){
		progression[i] = -1;
	}
	progression[0] = 0;
	progression[1] = 1;
	//printf("%d", fibonacci(12));
	while(true){
		int input;
		scanf("%d", &input);
		printf("%d\n\n", fibonacci(input));
	}
	return 0;
}