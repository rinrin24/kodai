# 基礎プログラミングおよび演習レポート ＃12
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」):個人作業
* 提出日付: 2022/12/19

# [課題の再掲]
「0番目から30番目までのフィボナッチ数列を打ち出す」プログラムを作れ、さらに、「0～30 までのいずれかの番号を入力すると、その番号のフィボナッチ数列を出力する」プログラムも作れ。

# [プログラム・実行例とその説明]
## sample3.c
```C
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
	while(true){
		int input;
		scanf("%d", &input);
		printf("%d\n\n", fibonacci(input));
	}
	return 0;
}
```

## 実行結果 
```
1
1

2
1

3
2

4
3

5
5

28
317811

29
514229

30
832040

31
1346269

32
2178309

33
3524578

34
5702887

35
9227465
```

与えられた引数のフィボナッチ数列を返す関数、`fibonacci`を作った。

ロジックは単純なものだが、再帰処理と動的計画法を使っている。

与えられた課題の様に、実行時の一番最初に0~30まですべて計算するのではなく、必要に応じて計算してデータを保存し、次に使うときに高いパフォーマンスを発揮する。

31以降は、配列の要素から超えてしまっているため、普通にフィボナッチ数列を計算しているが、30以下の値が必要になると、保存されているデータが参照される。

# [課題に対する報告]
動的計画法を適切に使用することができた。

# [考察]
手続き型言語の宿命だが、データとロジックが分離しているため、動的計画に使ったデータはグローバルスコープに置く必要があった。

# [アンケート]
## Q1. C言語で配列を取り扱えるようになりましたか。
使えるようになりました。しかし、長さが不変の配列しか使えないのは時に不便に感じる。

## Q2. 動的計画法を理解しましたか。またどのように思いましたか。
理解しました。非常に大きな、同じデータを扱う処理にならば適していると考える。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。 
素数判定のプログラムでも使えそうだと思った。