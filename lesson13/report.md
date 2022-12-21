# 基礎プログラミングおよび演習レポート ＃13
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」): 個人作業
* 提出日付:　2022/12/21

# [課題の再掲]
2次元以上の配列を使った自分の面白いと思うプログラムを作りなさい。

# [プログラム・実行例とその説明]
## sample6.rb
```C
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
```

## 出力結果
```
543
761
 28
a
6
543
761
2 8
s
543
7 1
268
a
4
543
71
268
w
543
718
26
d
543
718
2 6
d
543
718
 26
s
543
 18
726
s
 43
518
726
a
0
4 3
518
726
w
413
5 8
726
w
413
528
7 6
d
413
528
 76
s
413
 28
576
s
 13
428
576
a
0
1 3
428
576
w
123
4 8
576
a
4
123
48
576
w
123
486
57
d
123
486
5 7
s
123
4 6
587
d
123
 46
587
w
123
546
 87
a
6
123
546
8 7
s
123
5 6
847
d
123
 56
847
w
123
856
 47

a
6
123
856
4 7
s
123
8 6
457
a
4
123
86
457
w
123
867
45
d
123
867
4 5
s
123
8 7
465
a
4
123
87
465
w
123
875
46
d
123
875
4 6
s
123
8 5
476
a
4
123
85
476
d
123
8 5
476
d
123
 85
476
w
123
485
 76
a
6
123
485
7 6
s
123
4 5
786
a
4
123
45
786
d
123
4 5
786
w
123
485
7 6
a
7
123
485
76
d
123
485
7 6
a
7
123
485
76
d
123
485
7 6
d
123
485
 76
s
123
 85
476
a
3
123
8 5
476
a
4
123
85
476
w
123
856
47
d
123
856
4 7
s
123
8 6
457
d
123
 86
457
w
123
486
 57
a
6
123
486
5 7
s
123
4 6
587
d
123
 46
587
a
3
123
4 6
587
a
4
123
46
587
w
123
467
58
d
123
467
5 8
s
123
4 7
568
d
123
 47
568
w
123
547
 68
s
123
 47
568
a
3
123
4 7
568
a
4
123
47
568
w
123
478
56
d
123
478
5 6
d
123
478
 56
s
123
 78
456
a
3
123
7 8
456
w
123
758
4 6
a
7
123
758
46
s
123
75
468
d
123
7 5
468
w
123
765
4 8
a
7
123
765
48
s
123
76
485
d
123
7 6
485
d
123
 76
485
w
123
476
 85
a
6
123
476
8 5
s
123
4 6
875
w
123
476
8 5
a
7
123
476
85
s
123
47
856
sd
12 
473
856
1 2
473
856
w
172
4 3
856
s
1 2
473
856
a
1
12
473
856
w
123
47
856
d
123
4 7
856
w
123
457
8 6
a
7
123
457
86
s
123
45
867
d
123
4 5
867
w
123
465
8 7
s
123
4 5
867
d
123
 45
867
w
123
845
 67
a
6
123
845
6 7
s
123
8 5
647
a
4
123
85
647
w
123
857
64
d
123
857
6 4
s
123
8 7
654
a
4
123
87
654
w
123
874
65
d
123
874
6 5
d
123
874
 65
s
123
 74
865
a
3
123
7 4
865
a
4
123
74
865
w
123
745
86
d
123
745
8 6
d
123
745
 86
s
123
 45
786
a
3
123
4 5
786
a
4
123
45
786
w
123
456
78
----------
Congratulations!
You have solved the puzzle!

Result
----------
Level: 3
Number of Movement: 126
Time: 95sec
```

二次元配列を使ってスライドパズルを作った。

機能としては、まずランダムに *n * n* 個(基本的には *3 * 3* , もしくは *4 * 4*)のマスを作り、それぞれを 0~9の数字で重複しないように埋める。

表示する際は、0の部分のみを半角スペースで表示し、ここを空欄とする。

w, a, s, dのいずれかを入力すると、空欄になっているマスに対して隣接するマスをスライドする。

マスの中の数字が左上から右上、左下、右下の順で昇順になっていればゲームクリアとなる。

プログラムについては、まず最初に二次元配列を定義し、`initializeGrid()`関数を呼び出して、配列を初期化、つまりランダムな数字(16進char型)をそれぞれの要素に代入している。

`displayGrid()`関数で、二次元配列をグリッド状に表示する。ここで、`'0'`	が代入されている要素の部分は半角スペースで表示しており、空欄を表現している。

また、始めに後に記録するために必要な現在のCPU時間とマスを移動させた回数を初期化する。

次に`while()`で無限ループを発生させ、入力を待つ。

a, w, d, sが入力された場合、それぞれ`moveLeft()`関数、`moveUp()`関数、`moveRight()`関数、`moveDown()`関数を呼び出す。

それぞれの関数は与えられた引数のグリッドをスライドさせる。まず`findCell()`関数により`'0'`が代入されているマス(二次元配列の要素)を探し、そのマスの右、下、左、上に隣接するマスの値を空欄のマスに代入し、隣接するマスに`'0'`を代入する。これによってマスがスライドされる。

次に、グリッドを表示する。しかし、入力がa, w, d, s以外であった場合(改行など)は`continue`により再表示しないようにしている。

最後に`isSolved()`関数によりパズルが完成しているかを判断し、完成しているなら`while`ループを抜ける。

ループから抜けると結果が表示し、グリッドの列の数、マスを動かした回数、かかった時間(s)が表示される。

# [課題に対する報告]
C言語で二次元配列を適切に使うことができた。

# [考察]
`initializeGrid()`関数で要素を初期化する際、`rand()`関数で得た数字を16進の文字列に変換する際に`sprintf()`関数を使っていたが、安全性などを鑑みて`sprintd_s()`関数を使うべきだったかもしれない。

# [アンケート]
## Q1. 文字列の基本的な操作ができるようになりましたか。
できるようになりました。

便利な関数はいくつか保存しておき、他のところでも使えるようにすると便利だとおもう。

もしC言語にもString型が合ったらよかったのに、とも感じた。

## Q2.  文字列から整数や実数を作り出す原理が分かりましたか。
理解した。

ASCIIコードから変換するのも面白いかもしれない。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
配列の要素数を指定するために`#define`を使っているが、望ましいのかがあまりわからない。

できれば動的な配列が使いたい。