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
	/*for(int i = 0; i < 10; i++){
		img_fillAlphaCircle(headLightColor, WIDTH/3, HEIGHT*3/4, WIDTH/12 - 20 + i * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);
		img_fillAlphaCircle(headLightColor, WIDTH*2/3, HEIGHT*3/4, WIDTH/12 - 20 + i * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);*/
	for(int i = 1; i < 10; i++){
		img_fillAlphaDounut(headLightColor, WIDTH/3, HEIGHT*3/4, WIDTH/12 - 20 + i * 10, WIDTH/12 - 20 + (i - 1) * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);
		img_fillAlphaDounut(headLightColor, WIDTH*2/3, HEIGHT*3/4, WIDTH/12 - 20+ i * 10, WIDTH/12 - 20 + (i - 1) * 10, MAX_ALPHA - 100 - i * MAX_ALPHA / 2 / 10);
	}
	img_fillAlphaCircle(headLightColor, WIDTH/3, HEIGHT*3/4, WIDTH/12 - 20, MAX_ALPHA - 100);
	img_fillAlphaCircle(headLightColor, WIDTH*2/3, HEIGHT*3/4, WIDTH/12 - 20, MAX_ALPHA - 100);
}