#include "mjc.h"

float CMJC::compute(ArrayXf &X, ArrayXf &Y, float beta){
    return min(getDist(X,Y,beta), getDist(Y,X,beta));
}

float CMJC::getDist(ArrayXf & X,ArrayXf & Y, float beta){
    int minLen=min(X.size(),Y.size());
    float std=sqrt((Y - Y.mean()).square().sum()/(Y.size()-1));
    float phi=beta*4.0f*std/((float)minLen);
    float d=0.0f;
    int tx=0;
    int ty=0;
    while ((tx<X.size())&&(ty<Y.size())){
        d+=getLocalDist(X,Y,tx,ty,phi);
        if ((tx>=X.size())||(ty>=Y.size())) break;
        d+=getLocalDist(Y,X,ty,tx,phi);
    }
    return d;
}

float CMJC::getLocalDist(ArrayXf &X,ArrayXf &Y,int &tx, int &ty, float &phi){
    int N = Y.size();
    float cmin = numeric_limits<double>::infinity();
    float c, delta = .0f, deltamin = .0f;
    while (ty + delta < N) {
        c = pow(phi*delta, 2);
        if (c >= cmin) {
            if (ty+delta>tx) break;
        } else {
            c+=pow(X(tx)-Y(ty+delta), 2);
            if (c < cmin) {
                cmin = c;
                deltamin = delta;
            }
        }
        delta +=1;
    }
    tx++;
    ty = ty + deltamin+1;
    return cmin;
}

