#include "mjc.h"

float CMJC::compute(ArrayXf &X, ArrayXf &Y, float beta){
     return min(this->getDist(X,Y,beta), this->getDist(Y,X,beta));
}

float CMJC::getDist(ArrayXf & X,ArrayXf & Y, float beta){
     int minLen=min(X.size(),Y.size());
     int maxLen=max(X.size(),Y.size());
     float std=std::sqrt((Y - Y.mean()).square().sum()/(Y.size()-1));;
     float phi=beta*4.0f*std/((float)minLen);
     float d=0.0f;
     int tx=0;
     int ty=0;
     while((tx<X.size())&&(ty<Y.size())){
          d+=this->getLocalDist(X,Y,tx,ty,phi);
          if((tx>=X.size())||(ty>=Y.size())) break;
          d+=this->getLocalDist(Y,X,ty,tx,phi);
     }
     return d;
}

float CMJC::getLocalDist(ArrayXf &X,ArrayXf &Y,int &tx, int &ty, float &phi){
     int M = X.size();
     float cmin = pow(10, 10);
     float c, delta = .0f, deltamin = .0f;
     while (ty + delta < M) {
          c = pow(phi*delta, 2);
          if (c > cmin) {
               if (ty+delta>tx) break;
               continue;            
          }
          c+=pow(X(tx)-Y(ty+delta), 2); 
          if (c < cmin) {
                cmin = c;
                deltamin = delta;  
          }
          delta +=1;
     }
     tx++;
     ty+=deltamin+1;
     return cmin;
}


