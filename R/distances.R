##
## Copyright (c) 2019-2020 of Paulius Danenas
##
## This file is part of the TSDistExtra package.
##
## DTW is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## DTW is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
## License for more details.
##
## You should have received a copy of the GNU General Public License
## along with DTW.  If not, see <http://www.gnu.org/licenses/>.
##


#' Compute Time Warped Edit distance, Minimum Jump Cost or Fast Dynamitc Time Warping distances
#' 
#' @title Inherit Documentation for time series distances package
#' @name params_series 
#' @param X Numeric vector representing first time series
#' @param Y Numeric vector representing second time series
#' 
NULL
    

#' Time Warped Edit Distance (TWED)
#'
#' Original implementation of Time Warped Edit Distance (TWED) for discrete time series \code{X} and \code{Y} matching, first proposed in 2009 by P.-F. Marteau. 
#' The function computes TWED as the optimal alignment between two time series \code{X} and \code{Y}, given as numeric
#' vectors. Lengths of \code{X} and \code{Y} may differ.
#' Similar to Dynamic Time Warping (DTW), the distance between multiple time series can be calculated 
#' using \code{\link[=proxy::dist()]{proxy::dist()}}function in package \pkg{proxy} with the method given, 
#' or invoked on all pairs `x[i],y[j]` to build the distance matrix.
#' 
#' @usage TWEDistance(X, Y, Xts=NULL, Yts = NULL, nu = 0.001, lambda = 1.0, 
#'                    degree = 2)
#'  
#' @inheritParams params_series  
#' @param Xts Vector containing the time stamps for time series \code{X}. The length of this vector should match length of \code{X}
#' @param Yts Vector containing the time stamps for time series \code{Y}. The length of this vector should match length of \code{Y}
#' @param nu Elasticity parameter value, required to be 0 or more 
#' @param lambda Penalty for deletion operation
#' @param degree Power degree for the evaluation of the local distance between samples; \code{degree > 0} is required
#'
#' @return Numerical distance between time series \code{X} and \code{Y}
#' 
#' @references 
#' Marteau P. F. (2009). "Time Warp Edit Distance with Stiffness Adjustment for Time Series Matching". IEEE Transactions on Pattern Analysis and Machine Intelligence. 31 (2): 306–318. arXiv:cs/0703033. doi:10.1109/TPAMI.2008.76.   
#'
#' @examples
#' 
#' a <- runif(100) *100
#' b <- a + 5
#' TWEDistance(a, b)
#' 
#' @export TWEDistance

TWEDistance <- function(X, Y, Xts=NULL, Yts = NULL, nu = 0.001, lambda = 1.0, degree = 2) {
  if (is.null(Xts))
    Xts <- 1:length(X)
  if (is.null(Yts))
    Yts <- 1:length(Y)
  .Call('_TSDistExtra_TWEDistance__', PACKAGE = 'TSDistExtra', X, Xts, Y, Yts, nu, lambda, degree)
}


#' Minimum Jump Cost (MJC) Distance
#'
#' Original implementation of Minimum Jump Cost Distance (MJC) for discrete time series \code{X} and \code{Y} matching. 
#' The main idea behind MJC is that, if a given time series \code{X} resembles \code{X}, the cost  of iteratively ‘jumping’ between their samples should be small.
#' These jumps are performed iteratively done from the beginning of the time series until an end is reached, otherwise we would be discarding some 
#' possibly relevant parts of the time series. 
#' Similar to Dynamic Time Warping (DTW), the distance between multiple time series can be calculated 
#' using \code{\link[=proxy::dist()]{proxy::dist()}}function in package \pkg{proxy} with the method given, 
#' or invoked on all pairs `x[i],y[j]` to build the distance matrix.
#' 
#' @usage MJCDistance(X, Y, beta = 2)
#'  
#' @inheritParams params_series  
#' @param beta Controls the complexity of advancing in time
#'
#' @return Numerical distance between time series \code{X} and \code{Y}
#' 
#' @references 
#' Serrà J., Arcos J.L. (2012) A Competitive Measure to Assess the Similarity between Two Time Series. In: Agudo B.D., Watson I. (eds) Case-Based Reasoning Research and Development. ICCBR 2012. Lecture Notes in Computer Science, vol 7466. Springer, Berlin, Heidelberg.   
#'
#' @examples
#' 
#' a <- runif(100) *100
#' b <- a + 5
#' MJCDistance(a, b)
#' 
#' @export MJCDistance

MJCDistance <- function(X, Y, beta = 2) {
  .Call('_TSDistExtra_MJCDistance__', PACKAGE = 'TSDistExtra', X, Y, beta)
}


#' Pruned Dynamic Time Warping (Pruned DTW) Distance
#'
#' Implements Dynamic Time Warping with Pruned Warping  Paths (PrunedDTW).The main speed-up comes from recognition and pruning cells 
#' in the DTW matrix that are guaranteed to not lead to alignments that will result in the optimal path.. 
#' Similar to Dynamic Time Warping (DTW), the distance between multiple time series can be calculated 
#' using \code{\link[=proxy::dist()]{proxy::dist()}}function in package \pkg{proxy} with the method given, 
#' or invoked on all pairs `x[i],y[j]` to build the distance matrix.
#' 
#' @usage PrunedDTWDistance(X, Y, window = 1)
#'  
#' @inheritParams params_series  
#' @param window Window size
#'
#' @return Numerical distance between time series \code{X} and \code{Y}
#' 
#' @references 
#' Silva D.F, Batista G. (2016) Speeding Up All-Pairwise Dynamic Time Warping Matrix Calculation. SDM 2016: 837-845
#'
#' @examples
#' 
#' a <- runif(100) *100
#' b <- a + 5
#' PrunedDTWDistance(a, b)
#' 
#' @export PrunedDTWDistance

PrunedDTWDistance <- function(X, Y, window = 1) {
  .Call('_TSDistExtra_PrunedDTWDistance__', PACKAGE = 'TSDistExtra', X, Y, window)
}