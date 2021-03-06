% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distances.R
\name{MJCDistance}
\alias{MJCDistance}
\title{Minimum Jump Cost (MJC) Distance}
\usage{
MJCDistance(X, Y, beta = 2)
}
\arguments{
\item{X}{Numeric vector representing first time series}

\item{Y}{Numeric vector representing second time series}

\item{beta}{Controls the complexity of advancing in time}
}
\value{
Numerical distance between time series \code{X} and \code{Y}
}
\description{
Original implementation of Minimum Jump Cost Distance (MJC) for discrete time series \code{X} and \code{Y} matching. 
The main idea behind MJC is that, if a given time series \code{X} resembles \code{X}, the cost  of iteratively ‘jumping’ between their samples should be small.
These jumps are performed iteratively done from the beginning of the time series until an end is reached, otherwise we would be discarding some 
possibly relevant parts of the time series. 
Similar to Dynamic Time Warping (DTW), the distance between multiple time series can be calculated 
using \code{\link[=proxy::dist()]{proxy::dist()}}function in package \pkg{proxy} with the method given, 
or invoked on all pairs `x[i],y[j]` to build the distance matrix.
}
\examples{

a <- runif(100) *100
b <- a + 5
MJCDistance(a, b)

}
\references{
Serrà J., Arcos J.L. (2012) A Competitive Measure to Assess the Similarity between Two Time Series. In: Agudo B.D., Watson I. (eds) Case-Based Reasoning Research and Development. ICCBR 2012. Lecture Notes in Computer Science, vol 7466. Springer, Berlin, Heidelberg.
}
