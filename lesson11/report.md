# 基礎プログラミングおよび演習レポート ＃11
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」):個人作業
* 提出日付: 2022/12/19

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
	displayArray(array, arrayLength);
	return 0;
}
```

## 実行結果
```
[41, 8467, 6334, 6500, 9169, 5724, 1478, 9358, 6962, 4464, 5705, 8145, 3281, 6827, 9961, 491, 2995, 1942, 4827, 5436, 2391, 4604, 3902, 153, 292, 2382, 
7421, 8716, 9718, 9895, 5447, 1726, 4771, 1538, 1869, 9912, 5667, 6299, 7035, 9894, 8703, 3811, 1322, 333, 7673, 4664, 5141, 7711, 8253, 6868, 5547, 7644, 2662, 2757, 37, 2859, 8723, 9741, 7529, 778, 2316, 3035, 2190, 1842, 288, 106, 9040, 8942, 9264, 2648, 7446, 3805, 5890, 6729, 4370, 5350, 5006, 1101, 4393, 3548, 9629, 2623, 4084, 9954, 8756, 1840, 4966, 7376, 3931, 6308, 6944, 2439, 4626, 1323, 5537, 1538, 6118, 2082, 2929, 6541]
[37, 41, 106, 153, 288, 292, 333, 491, 778, 1101, 1322, 1323, 1478, 1538, 1538, 1726, 1840, 1842, 1869, 1942, 2082, 2190, 2316, 2382, 2391, 2439, 2623, 
2648, 2662, 2757, 2859, 2929, 2995, 3035, 3281, 3548, 3805, 3811, 3902, 3931, 4084, 4370, 4393, 4464, 4604, 4626, 4664, 4771, 4827, 4966, 5006, 5141, 5350, 5436, 5447, 5537, 5547, 5667, 5705, 5724, 5890, 6118, 6299, 6308, 6334, 6500, 6541, 6729, 6827, 6868, 6944, 6962, 7035, 7376, 7421, 7446, 7529, 7644, 7673, 7711, 8145, 8253, 8467, 8703, 8716, 8723, 8756, 8942, 9040, 9169, 9264, 9358, 9629, 9718, 9741, 9894, 9895, 9912, 9954, 9961]
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