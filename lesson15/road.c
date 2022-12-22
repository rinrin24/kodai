#include "road.h"

void drawRoad(int frame) {
    struct coordinate quadranglePoint[4] = {{955, 545}, {965, 545}, {1920, 1080}, {0, 1080}};
    img_fillQuadrangle(roadColor, quadranglePoint);
}
