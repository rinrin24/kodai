#pragma once
#define WIDTH 1920
#define HEIGHT 1080
#define MAX_ALPHA 255
struct color { unsigned char r, g, b; };
struct coordinate { int x, y; };
void img_clear(void);
void img_write(void);
void img_putpixel(struct color c, int x, int y);
void img_putAlphaPixel(struct color c, int x, int y, int alpha);
void img_fillcircle(struct color c, double x, double y, double r);
void img_fillQuadrangle(struct color c, struct coordinate coodinates[4]);
void img_fillAlphaCircle(struct color c, double x, double y, double r, int alpha);
void img_fillAlphaDounut(struct color c, double x, double y, double r, double r2, int alpha);

static struct coordinate getCenterPosition(struct coordinate coordinates[4]);