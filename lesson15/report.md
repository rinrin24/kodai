# 基礎プログラミングおよび演習レポート ＃15
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」): 藤森一朗
* 提出日付: 2022/12/22

# [構想・計画・設計]
## 構想
どのような動画を作るべきかを考えたとき、私は浜辺での日の出、もしくは夜のビル街で自動車が走っているのをタイムラプスにした風景を提案した。
その後者にインスピレーションを受けたのか、相方はトンネルで車が走っている風景を提案し、それに決めた。

## 計画
構図としては、自動車の一人称視点で、トンネルの壁が色の変化によって動いているように見えるようにし、またトンネルのオレンジ色のライトを動かすことで奥に進んでいるように表現し、また白い円をぼんやりと表示することで車のヘッドライトを表現しようとした。

## 設計
まず私たちはいくつかの要素に分けた:
* トンネルの壁
* トンネルのライト
* ヘッドライト
* 道路
* 道路の白線
 
の6つの要素に分けた。

そしてそれぞれに必要な図形を列挙した:
* 塗りつぶされている円
* 塗りつぶされている任意の四角形
* 透明度を持つ塗りつぶされている円
* 透明度を持つ塗りつぶされているドーナツ型

の4つが挙げられた。

私たちは「整った構造」のコードというものを、それぞれの関数の行う処理が少なく、また関数同士が密になっていなくて分離しやすい構造だと考えたため、それらを全て分離した。

# [プログラムコード]
## main.c
```C
#include <stdio.h>
#include "./img.h"
#include "./tunnelLight.h"
#include "./road.h"
#include "./roadWhiteLine.h"
#include "./tunnelWall.h"
#include "./headLight.h"
int main(void) {
	const int MAX_FRAME = 60;
	for(int i = 0; i < MAX_FRAME; i++){
		img_clear();
        drawTunnelWall(i);
        drawRoad(i);
        drawRoadWhiteLine(i);
		drawTunnelLight(i);
		drawHeadLight(i);
		img_write();
        printf("%d of %d complete\n", i+1, MAX_FRAME);
	}
	return 0;
}
```
## img.c
```C
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "img.h"
static unsigned char buf[HEIGHT][WIDTH][3];
static int filecnt = 0;
static char fname[100];
void img_clear(void) {
	/*テキストのものと同じなので省略*/
}
void img_write(void) {
	sprintf(fname, "outputImage/img%04d.ppm", ++filecnt);
	FILE *f = fopen(fname, "wb");
	if(f == NULL) { fprintf(stderr, "can’t open %s\n", fname); exit(1); }
	fprintf(f, "P6\n%d %d\n255\n", WIDTH, HEIGHT);
	fwrite(buf, sizeof(buf), 1, f);
	fclose(f);
}
void img_putpixel(struct color c, int x, int y) {
	/*テキストのものと同じなので省略*/
}
void img_putAlphaPixel(struct color c, int x, int y, int alpha){
	if(x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT)	return;
	buf[y][x][0] = (buf[y][x][0] * (MAX_ALPHA - alpha) + c.r * alpha) / MAX_ALPHA;
	buf[y][x][1] = (buf[y][x][1] * (MAX_ALPHA - alpha) + c.g * alpha) / MAX_ALPHA;
	buf[y][x][2] = (buf[y][x][2] * (MAX_ALPHA - alpha) + c.b * alpha) / MAX_ALPHA;;
}
void img_fillcircle(struct color c, double x, double y, double r) {
	int imin = (int)(x - r - 1), imax = (int)(x + r + 1);
	int jmin = (int)(y - r - 1), jmax = (int)(y + r + 1);
	if(imin < 0) imin = 0;
	if(jmin < 0) jmin = 0;
	if(imax > WIDTH) imax = WIDTH;
	if(jmax > HEIGHT) jmax = HEIGHT;
	for(int j = jmin; j <= jmax; ++j) {
		for(int i = imin; i <= imax; ++i) {
			if((x-i)*(x-i) + (y-j)*(y-j) <= r*r) { img_putpixel(c, i, j); }
		}
	}
}
void img_fillQuadrangle(struct color c, struct coordinate *coordinates) {
	//四角形の重心の座標
	const float centerX = getCenterPosition(coordinates).x;
	const float centerY = getCenterPosition(coordinates).y;
	double slope[4], slice[4], line[4];
	for(int i = 0; i < 4; i++){
		slope[i] = 	(float)(coordinates[i].y - coordinates[(i+1)%4].y) / (coordinates[i].x - coordinates[(i+1)%4].x);
		slice[i] = (float)(coordinates[i].y) - slope[i] * coordinates[i].x;
		line[i] = 1;
		if(centerY >= (slope[i] * centerX + slice[i])) line[i] = -1;
	}
	for(int y = 0; y < HEIGHT; y++){
		for(int x = 0; x < WIDTH; x++){
			bool isQuad[4];
			for(int i = 0; i < 4; i++){
				isQuad[i] = (y * line[i]) <= ((slope[i] * x + slice[i]) * line[i]);
			}
			if(isQuad[0] && isQuad[1]){
				if(isQuad[2] && isQuad[3]){
					img_putpixel(c, x, y);
				}
			}
		}
	}
}
void img_fillAlphaCircle(struct color c, double x, double y, double r, int alpha){
	int imin = (int)(x - r - 1), imax = (int)(x + r + 1);
	int jmin = (int)(y - r - 1), jmax = (int)(y + r + 1);
	if(imin < 0) imin = 0;
	if(jmin < 0) jmin = 0;
	if(imax > WIDTH) imax = WIDTH;
	if(jmax > HEIGHT) jmax = HEIGHT;
	int i, j;
	for(j = jmin; j <= jmax; ++j) {
		for(i = imin; i <= imax; ++i) {
			if((x-i)*(x-i) + (y-j)*(y-j) <= r*r) img_putAlphaPixel(c, i, j, alpha);
		}
	}
}
void img_fillAlphaDounut(struct color c, double x, double y, double r, double r2, int alpha){
	int imin = (int)(x - r - 1), imax = (int)(x + r + 1);
	int jmin = (int)(y - r - 1), jmax = (int)(y + r + 1);
	if(imin < 0) imin = 0;
	if(jmin < 0) jmin = 0;
	if(imax > WIDTH) imax = WIDTH;
	if(jmax > HEIGHT) jmax = HEIGHT;
	int i, j;
	for(j = jmin; j <= jmax; ++j) {
		for(i = imin; i <= imax; ++i) {
			if((x-i)*(x-i) + (y-j)*(y-j) <= r*r){
				if((x-i)*(x-i) + (y-j)*(y-j) > r2*r2)
					img_putAlphaPixel(c, i, j, alpha);
			}
		}
	}
}

static struct coordinate getCenterPosition(struct coordinate *coordinates){
	int centerX = 0;
	int centerY = 0;
	double slope[4], slice[4], line[4];
	for(int i = 0; i < 4; i++){
		centerX += coordinates[i].x;
		centerY += coordinates[i].y;
		slope[i] = 0; slice[i] = 0; line[i] = 1;
	}
	centerX = centerX / 4;
	centerY = centerY / 4;
	struct coordinate newCoordinate = {centerX, centerY};
	return newCoordinate;
}
```
## tunnelLight.c
```C
#include "tunnelLight.h"
#include "math.h"
#include <stdio.h>

void drawTunnelLight(int frame) {
	const float LIGHT_SPEED = 1.2;
	const int LIGHT_NUM = 3;
	const int LIGHT_SPAN = 60;
	const float CENTERX = 0.5 * WIDTH;
	const float CENTERY = 0.5 * HEIGHT;
	const float SIZEX = 1.0 * WIDTH;
	const float SIZEY = 1.0 * HEIGHT;

	float dlightX[4], dlightY[4];
	int lightX[4], lightY[4];
	{
		const float slopeT = (CENTERY - (SIZEY / 5 - 60)) / (CENTERX - 0);
		const float slopeB = (CENTERY - (SIZEY / 5 + 60)) / (CENTERX - 0);
		const float sliceT = CENTERY - slopeT * CENTERX;
		const float sliceB = CENTERY - slopeB * CENTERX;
		struct coordinate quadranglePoint[4];
		for (int i = 0; i < 3; i++) {
			const float curTX = CENTERX - powf(LIGHT_SPEED, ((frame + i * LIGHT_SPAN / LIGHT_NUM) % LIGHT_SPAN));
			const float curTY = slopeT * curTX + sliceT;
			const float hoge = powf(curTX - CENTERX, 2) + powf(curTY - CENTERY, 2);
			const float curBX = ((slopeB * CENTERY + CENTERX - slopeB * sliceB) - sqrt(powf(slopeB * CENTERY + CENTERX - slopeB * sliceB, 2) - (powf(CENTERX, 2) + powf(CENTERY, 2) - 2 * sliceB * CENTERY + powf(sliceB, 2) - hoge) * (powf(slopeB, 2) + 1))) / (powf(slopeB, 2) + 1);
			const float curBY = slopeB * curBX + sliceB;
			dlightX[0] = CENTERX - 1.5 * powf(LIGHT_SPEED, ((frame + i * LIGHT_SPAN / LIGHT_NUM) % LIGHT_SPAN));
			dlightX[1] = curTX;
			dlightX[2] = curBX;
			dlightX[3] = CENTERX - 1.5 * (CENTERX - curBX);
			dlightY[0] = dlightX[0] * slopeT + sliceT;
			dlightY[1] = dlightX[1] * slopeT + sliceT;
			dlightY[2] = dlightX[2] * slopeB + sliceB;
			dlightY[3] = dlightX[3] * slopeB + sliceB;
			for (int j = 0; j < 4; j++) {
				lightX[j] = 1 * dlightX[j];
				lightY[j] = 1 * dlightY[j];
				quadranglePoint[j].x = lightX[j];
				quadranglePoint[j].y = lightY[j];
			}
			img_fillQuadrangle(lightColor, quadranglePoint);
		}
	}
	{
		const float slopeT = (CENTERY - (SIZEY / 6 - 60)) / (CENTERX - SIZEX);
		const float slopeB = (CENTERY - (SIZEY / 6 + 60)) / (CENTERX - SIZEX);
		const float sliceT = CENTERY - slopeT * CENTERX;
		const float sliceB = CENTERY - slopeB * CENTERX;
		struct coordinate quadranglePoint[4];
		for (int i = 0; i < 3; i++) {
			const float curTX = CENTERX + powf(LIGHT_SPEED, ((frame + i * LIGHT_SPAN / LIGHT_NUM) % LIGHT_SPAN));
			const float curTY = slopeT * curTX + sliceT;
			const float hoge = powf(curTX - CENTERX, 2) + powf(curTY - CENTERY, 2);
			const float curBX = ((slopeB * CENTERY + CENTERX - slopeB * sliceB) + sqrt(powf(slopeB * CENTERY + CENTERX - slopeB * sliceB, 2) - (powf(CENTERX, 2) + powf(CENTERY, 2) - 2 * sliceB * CENTERY + powf(sliceB, 2) - hoge) * (powf(slopeB, 2) + 1))) / (powf(slopeB, 2) + 1);
			const float curBY = slopeB * curBX + sliceB;
			dlightX[0] = CENTERX + 1.5 * powf(LIGHT_SPEED, ((frame + i * LIGHT_SPAN / LIGHT_NUM)%LIGHT_SPAN));
			dlightX[1] = curTX;
			dlightX[2] = curBX;
			dlightX[3] = CENTERX - 1.5 * (CENTERX - curBX);
			dlightY[0] = dlightX[0] * slopeT + sliceT;
			dlightY[1] = dlightX[1] * slopeT + sliceT;
			dlightY[2] = dlightX[2] * slopeB + sliceB;
			dlightY[3] = dlightX[3] * slopeB + sliceB;
			for (int j = 0; j < 4; j++){
				lightX[j] = 1 * dlightX[j];
				lightY[j] = 1 * dlightY[j];
				quadranglePoint[j].x = lightX[j];
				quadranglePoint[j].y = lightY[j];
			}
			img_fillQuadrangle(lightColor, quadranglePoint);
		}
	}
}
```
## road.c
```C
#include "road.h"

void drawRoad(int frame) {
    struct coordinate quadranglePoint[4] = {{955, 545}, {965, 545}, {1920, 1080}, {0, 1080}};
    img_fillQuadrangle(roadColor, quadranglePoint);
}

```
## roadWhiteLine.c
```C
#include "roadWhiteLine.h"

void drawRoadWhiteLine(int frame) {
    struct coordinate quadranglePoint[4] = {{961, 580}, {959, 580}, {930, 1080}, {990, 1080}};
    img_fillQuadrangle(roadWhiteLineColor, quadranglePoint);
}

```
## tunnelWall.c
```C
#include "tunnelWall.h"
#include "math.h"
void drawTunnelWall(int frame){
    int depth = 17;
    int segments[17];
    double tunnelSegmentSizeRate = 1.8;
    for(int i = depth; i > 0; i--){
        segments[i - 1] = (18 + (frame % 8)) * pow(tunnelSegmentSizeRate, depth - i);
    }
    
    int brightestColor = 120;
    for(int i = 0; i < depth; i++){
        int tColor = brightestColor - (i * 3);
        struct color curColor = {tColor, tColor, tColor};
        img_fillcircle(curColor, 960, 540, segments[i]);
    }
}

```
## headLight.c
```C
#include "headLight.h"

void drawHeadLight(int frame){
	if((frame % 40) <= 20){
		for(int i = 1; i < 10; i++){
			img_fillAlphaDounut(headLightColor, WIDTH/3, HEIGHT*3/4, WIDTH/12 + i * 10, WIDTH/12 + (i - 1) * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);
			img_fillAlphaDounut(headLightColor, WIDTH*2/3, HEIGHT*3/4, WIDTH/12 + i * 10, WIDTH/12 + (i - 1) * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);
		}
		img_fillAlphaCircle(headLightColor, WIDTH/3, HEIGHT*3/4, WIDTH/12, MAX_ALPHA - 100);
		img_fillAlphaCircle(headLightColor, WIDTH*2/3, HEIGHT*3/4, WIDTH/12, MAX_ALPHA - 100);
		return;
	}
	for(int i = 1; i < 10; i++){
		img_fillAlphaDounut(headLightColor, WIDTH/3, HEIGHT*3/4, WIDTH/12 - 20 + i * 10, WIDTH/12 - 20 + (i - 1) * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);
		img_fillAlphaDounut(headLightColor, WIDTH*2/3, HEIGHT*3/4, WIDTH/12 - 20+ i * 10, WIDTH/12 - 20 + (i - 1) * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);
	}
	img_fillAlphaCircle(headLightColor, WIDTH/3, HEIGHT*3/4, WIDTH/12 - 20, MAX_ALPHA - 100);
	img_fillAlphaCircle(headLightColor, WIDTH*2/3, HEIGHT*3/4, WIDTH/12 - 20, MAX_ALPHA - 100);
}
```
# [プログラムの説明]
まず4つの図形を`img.h`に定義した。透明度を持つ図形を表現するために、新たに`img_putAlphaPixel()`という関数を用意し、既に描画されている点とそれに重ねたい点の色を合成できるようにした。加えて、ファイル構造を整えるために`img_write()`関数の出力先を変更し、`outputImage/`という名前のディレクトリ内に画像ファイルを出力するようにした。

そして6つの要素をそれぞれヘッダファイルとして分離し、描画を行う関数をそれぞれに実装した。描画を行う関数は基本的に`draw**()`の形で表現され、引数に現在のコマの番号を取る。それらの関数から`img.h`内に定義された図形の描画する関数を呼び出し、そのコマで描画すべき画像を出力している。

最後に`main.c`での`main()`関数にてforループでコマを計算し、それぞれの描画する関数を呼び出して出力している。

# [開発過程の説明]
私は`img.h`にて新たな図形を描画する関数、`tunnelLight.h`にてトンネル内で動いているライトを描画する関数、そして`headLight.h`にて自動車のヘッドライトを描画する関数の作成を担った。残りの関数は相方に頼んだ。

一番苦労したのは`tunelLight.h`でのトンネルのライトの描画だった。非常に複雑な計算をする必要があり、一度相方に頼むも、難しかったらしく、結局私が担うこととなり、結果的に計算式を作るのに1週間程度時間がかかってしまった。

ロジックとしては、まずライトの上の二つの点が通る1次関数を求め、下の点の一次関数も求めた。そして四角形の右上の座標を二次関数的に中心から遠くなるようにして定めた。それらから三平方の定理などを使って4つの点の座標を求めた。

ライトはぼやけて見えるように中心から少しずつ半径を大きく、透明度を高くして円を描画しようとしたが、真ん中はいくつも円を重ねてしまっているためにとてもライトの色が濃くなってしまったため、最初に真ん中だけを円で描画し、その周りをドーナツ型の図形を描画するようにした。

# [考察]
チームで分担するのはとても大変だった。手続き型言語ではデータとロジックが分離しており、オブジェクト指向言語の様に**一つの部品**として分離することがそこまで容易ではなかった。

ファイルの外から参照されたくなかったため、多くの変数に`static`修飾子をつけることで何とかそれを回避した。

# [アンケート]
## Q1. うまく分担して課題プログラムを開発できましたか。
分担はまずまず上手くいったと思う。

ただやはり少し技量の差などからプログラムの量に差はできてしまった。

## Q2. 複数で分担する際に注意すべきことは何だと思いましたか。
コーディング規約とコミュニケーションだと思う。

今回は時間がなかったため設けなかったが、コーディング規約は非常に重要だと思う。特にドキュメントコメントを書くと分担作業の効率は大きく上がるだろう。

また、コミュニケーションが大事であるということも痛感した。自分は相手がわかっていると思っていたことも実際はわかっていなかったということが多くあり、自分だけが勝手に進んでいってしまったということがあったからだ。

## Q3. ここまでの科目全体を通して、学べたこと、学びたかったけど学べなかったことは何ですか。その他感想や、この科目の今後改善した方がよいこと、今後も維持したことがよいことの指摘もどうぞ。
### 学べたこと
基本的にはRubyの記法について色々学ぶことができた。純粋なオブジェクト指向言語に触ることができてよかった。

私はC言語は自分で勉強していたため、そこまで新たな要素はなかった。

### 学びたかったけど学べなかったこと
個人的に学びたかったのは画像ファイル出力としてではなく、Win32APIやDirectXなどを使ってウィンドウに表示して動的に動かせるGUIのプログラムの作り方など。

また、HTTPなどの通信技術やRailsなどを使ったウェブアプリケーションの技術についても少し学んでみたかった。

### 感想や改善した方がよいこと、今後も維持したことがよいこと
オブジェクト指向についてもうすこし詳しく説明したらよいと思った。GoFなどのデザインパターンや、クラスの継承や委譲など、また高度なものとしてはメモリがどう扱われているかなど。Rubyだと説明しきれないものもあるので、インターフェースやパッケージの(もしくはそれに近い)機能を持つJavaやC#を少し扱ってみるのも一つの改善案だと感じた。

加えて、UMLなどのドキュメントの作り方などもやったらよかったかもしれない。たとえオブジェクト指向言語でなくともシーケンス図やアクティビティ図などは便利で、また場合によっては日常生活でも使えるようなものとなると考えたから。また、もしUMLについて教えるならば、モデリング技術も教えるべきだと考えた。

さらに、共同作業を円滑に進めるに当たって、gitなどのバージョン管理システムについても触れるべきだと感じた。

総合的には、今回の講義はよかったと思う。私にはレベルが少し合わない部分もあったかもしれないが、初心者向けのプログラミングとしてはとても良いものだと思った。来年もぜひ私の学校の後輩や同輩にこの講義を受けてもらいたい。