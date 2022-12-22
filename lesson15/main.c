#include <stdio.h>
#include "./img.h"
#include "./tunnelLight.h"
#include "./road.h"
#include "./roadWhiteLine.h"
#include "./tunnelWall.h"
#include "./headLight.h"
//gcc main.c img.c tunnelLight.c -o main -lm && ./main
//convert -delay 5 outputImage/img*.ppm out.gif
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