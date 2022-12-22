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