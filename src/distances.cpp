#include <RcppEigen.h>
#include "mjc.h"
#include "twed.h"
#include "prunedDTW.h"
using namespace Rcpp;
//
// [[Rcpp::depends(RcppEigen)]]
//
// [[Rcpp::export]]
float MJCDistance__(Eigen::ArrayXf &X, Eigen::ArrayXf &Y, float beta) {
    CMJC *mjc = new CMJC();
    return mjc->compute(X, Y, beta);
}

// [[Rcpp::export]]
double TWEDistance__(Eigen::ArrayXd X, Eigen::ArrayXd Xts, Eigen::ArrayXd Y, Eigen::ArrayXd Yts, double nu, double lambda, int degree) {
    double dist = .0f;
    int lenx = X.size();
    int leny = Y.size();
    if (Xts.size() == 0)
        Xts = Eigen::ArrayXd::LinSpaced(lenx, 1, lenx);
    if (Yts.size() == 0)
        Yts = Eigen::ArrayXd::LinSpaced(leny, 1, leny);
    CTWED(X.data(), &lenx, Xts.data(), Y.data(), &leny, Yts.data(), &nu, &lambda, &degree, &dist);
    return dist;
}

// [[Rcpp::export]]
double PrunedDTWDistance__(NumericVector X, NumericVector Y, double w) {
    return pruneddtw(as<std::vector<double> >(X), as<std::vector<double> >(Y), w);
}



