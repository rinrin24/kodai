# 基礎プログラミングおよび演習レポート ＃14
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」): 個人作業
* 提出日付: 2022/12/22

# [課題の再掲]
次のような関数を作ってみなさい。
* 色を明るく変化させる関数
* これを利用して、明るい色は暗く、暗い色は明るい色にして返す関数
* もとと明るさが同じくらいだけど色調が違う色がつくる関数
* RGB 値の増分 (マイナスでもよい) を受け取り、その分だけそれぞれの成分を増やす関数
* RGB 値それぞれに-10～10 の範囲のランダムな値を足すことで元とちょっとだけ違う色にする関数
* その他色の構造体のアドレスを受け取り、好きな変化を施す関数

# [プログラム・実行例とその説明]
## sample2.c
```C
// color2.c --- handle color struct with pointer.
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct color { unsigned char r, g, b; };
void showcolor(struct color c) {
	printf("\x1b[38;2;%d;%d;%dm", c.r, c.g, c.b);
	printf("%02x%02x%02x\n", c.r, c.g, c.b);
}
struct color readcolor(void) {
	int r, g, b;
	printf("r(0-255)> "); scanf("%d", &r);
	printf("g(0-255)> "); scanf("%d", &g);
	printf("b(0-255)> "); scanf("%d", &b);
	struct color ret = { r, g, b }; return ret;
}
void makedarker(struct color *p) {
	p->r = p->r / 2; p->g = p->g / 2; p->b = p->b / 2;
}
void makebrighter(struct color *p){
	p->r = p->r * 2 % 256; p->g = p->g * 2 % 256; p->b = p->b * 2 % 256;
}
void makereverse(struct color *p){
	p->r = 255 - p->r;
	p->g = 255 - p->g;
	p->b = 255 - p->b;
}
void makerot1(struct color *p){
	char tmp = p->r;
	p->r = p->g;
	p->g = p->b;
	p->b = tmp;
}
void makerot2(struct color *p){
	char tmp = p->r;
	p->r = p->b;
	p->b = p->g;
	p->g = tmp;
}
void addtocolor(struct color *p, int dr, int dg, int db){
	p->r = (p->r + dr) % 256;
	p->g = (p->g + dg) % 256;
	p->b = (p->b + db) % 256;
}
void varcolor(struct color *p){
	p->r = (p->r + (rand() % 21 - 10)) % 256;
	p->g = (p->g + (rand() % 21 - 10)) % 256;
	p->b = (p->b + (rand() % 21 - 10)) % 256;
}
void multiply(struct color *p, struct color q){
	p->r = (p->r * q.r) % 256;
	p->g = (p->g * q.g) % 256;
	p->b = (p->b * q.b) % 256;
}
void screen(struct color *p, struct color q){
	p->r = 255 - (255 - p->r) * (255 - q.r);
	p->g = 255 - (255 - p->g) * (255 - q.g);
	p->b = 255 - (255 - p->b) * (255 - q.b);
}
void overlay(struct color *p, struct color q){
	if(p->r < (255 / 2)) p->r = 2 * p->r * q.r;
	if(p->r >= (255 / 2)) p->r = 255 - 2 * (255 - p->r) * (255 - q.r);
	if(p->g < (255 / 2)) p->g = 2 * p->g * q.g;
	if(p->g >= (255 / 2)) p->g = 255 - 2 * (255 - p->g) * (255 - q.g);
	if(p->b < (255 / 2)) p->b = 2 * p->b * q.b;
	if(p->b >= (255 / 2)) p->b = 255 - 2 * (255 - p->b) * (255 - q.b);
}

int main(void) {
	srand((unsigned int)time(NULL));
	struct color c1 = readcolor(); showcolor(c1);
	printf("\x1b[m");
	struct color c2 = readcolor(); showcolor(c2);
	makedarker(&c1); showcolor(c1);
	makebrighter(&c1); makebrighter(&c1); showcolor(c1);
	makereverse(&c1); showcolor(c1);
	makerot1(&c1); showcolor(c1);
	makerot2(&c1); showcolor(c1);
	addtocolor(&c1, 100, 50, 100); showcolor(c1);
	varcolor(&c1); showcolor(c1);
	multiply(&c1, c2); showcolor(c1);
	screen(&c1, c2); showcolor(c1);
	overlay(&c1, c2); showcolor(c1);
	printf("\x1b[m");
	return 0;
}
```

## 実行結果
```
r(0-255)> 100
g(0-255)> 50
b(0-255)> 100
643264
r(0-255)> 50
g(0-255)> 100
b(0-255)> 150
326496
321932
c864c8
379b37
9b3737
379b37
9bcd9b
9dce9a
aa783c
ee4204
c59531
```

指示された関数はそのまま作った。

追加で二つの色を合成するために、乗算、スクリーン、オーバーレイの3種類の合成方式の関数を作った。

二つの`color`型の構造体を引数として受け取っているが、二つ目の引数は変えないため、ポインタではなく参照として渡した。

また、実際に色がどのようになっているかを即座に確認できるように、`showcolor()`関数を編集して、エスケープシーケンスを使ってコンソールで出力される文字に色を付けた。

# [課題に対する報告]
構造体や、構造体のポインタを適切に使うことができた。

# [考察]
オーバーレイを行う関数は乗算とスクリーンを足し合わせたものであるが、乗算、スクリーンの関数がそれぞれrgb全ての色を一度に処理しているため纏めることができなかった。

それぞれの色で分離するのも一つの改善案として存在している。

# [アンケート]
## Q1. 構造体を使ったプログラムが書けるようになりましたか。
書けるようになった。

構造体がサポートされていないがC言語と互換性のある言語でポインタを使って操作した。

## Q2. 表と検索とはどういうことか理解しましたか。
理解した。

STLのmapみたいだと感じた。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
変更が必要か否かでポインタ渡しと参照渡しを使い分けるのはよいと思う。