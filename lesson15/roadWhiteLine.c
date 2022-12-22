#include "roadWhiteLine.h"

void drawRoadWhiteLine(int frame) {
    struct coordinate quadranglePoint[4] = {{961, 580}, {959, 580}, {930, 1080}, {990, 1080}};
    img_fillQuadrangle(roadWhiteLineColor, quadranglePoint);
}
