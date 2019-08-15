#pragma once
#ifndef _MJC_H
#define _MJC_H

#include <RcppEigen.h>
using namespace std;
using Eigen::ArrayXf;

class CMJC{
private:
     vector<float> mPenalty;
public:
     CMJC(){};
     ~CMJC(){};
     float compute(ArrayXf &X,ArrayXf &Y,float beta);
private:
     float getDist(ArrayXf &X, ArrayXf &Y, float beta);
     float getLocalDist(ArrayXf &X,ArrayXf &Y,int &tx, int &ty, float &phi);
};

#endif
