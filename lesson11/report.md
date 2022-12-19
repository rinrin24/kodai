# 基礎プログラミングおよび演習レポート ＃11
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」):個人作業
* 提出日付:

# [課題の再掲]
C言語で作りたいプログラムを作れ。

# [プログラム・実行例とその説明]
## sample6.c
```C
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
	int *array = malloc(sizeof(int) * arrayLength);
	array = randArray(array, arrayLength);
	displayArray(array, arrayLength);
	combSort(array, arrayLength);
	printf("hello\n");
	displayArray(array, arrayLength);
	return 0;
}

```

整数の配列に対してコムソートを行うプログラムを作った。

ロジックはバブルソートを発展させたもので、間隔を適当に決めた後、そこでソートを行い、その間隔を狭めてを繰り返す。

計算量は *O(nlogn)* になるため、バブルソートの計算量の *O(n^2)* と比べて大幅に改善された。

しかし、コムソートの最悪計算量は *O(n^2)* であるため、場合によってはバブルソートと同じ性能となってしまう可能性がある。

# [課題に対する報告]
C言語でRubyのようにプログラムを記述することができた。

# [考察]
関数に配列を渡すときに、ポインタで渡してしまっているため、変数の変化が追いにくくなっているのが問題としてある。

# [アンケート]
## Q1. C言語でプログラムが書けるようになりましたか。
なりました。

## Q2. C と Ruby はどのように違うと感じていますか。
C言語は静的な型付け言語で、保守性能が高い反面、ポインタというレガシーな機能を搭載しており、開発保守性や、可読性を脅かしている。また、Rubyと違って動的にメモリ確保を行う配列や、クラスなどが実装されていないため、少し不便だ。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
静的な型付け言語を使っていて、かつ不変を活用しやすくても、ポインタから直接操作してしまうのは意味がないと感じた。