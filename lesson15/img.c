#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "img.h"
static unsigned char buf[HEIGHT][WIDTH][3];
static int filecnt = 0;
static char fname[100];
void img_clear(void) {
	int i, j;
	for(j = 0; j < HEIGHT; ++j) {
		for(i = 0; i < WIDTH; ++i) {
			buf[j][i][0] = buf[j][i][1] = buf[j][i][2] = 255;
		}
	}
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
	if(x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) { 	return; }
	buf[y][x][0] = c.r;
	buf[y][x][1] = c.g;
	buf[y][x][2] = c.b;
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