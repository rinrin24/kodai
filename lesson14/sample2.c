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