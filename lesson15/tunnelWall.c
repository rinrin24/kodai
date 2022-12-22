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
