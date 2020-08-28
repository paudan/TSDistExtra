\name{TSDistExtra-package}
\alias{TSDistExtra-package}
\alias{TSDistExtra}
\docType{package}
\title{
\packageTitle{TSDistExtra}
}
\description{
\packageDescription{TSDistExtra}
}
\details{
\packageDESCRIPTION{TSDistExtra}
\packageIndices{TSDistExtra}

\tabular{ll}{
Package: \tab TSDistExtra\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
License: \tab GPL (>=2) \cr
}
This package provides several distance measures which were developed to deal with time series which are not present in related packages (such as \link[TSdist:TSdist-package]{TSdist}). These measures can be used to measure ther similarity/dissimilarity between time series, perform clustering or other data analysis tasks which require the definition of a distance measure between time series.

The measures included are:
\itemize{
\item Time Warped Edit Distance \code{\link{TWEDistance}}
\item Minimum Jump Cost (MJC) \code{\link{MJCDistance}}
\item Pruned Dynamic Time Warping (PrunedDTW) \code{\link{PrunedDTWDistance}}
}
}

\author{
\packageAuthor{TSDistExtra}

Maintainer: \packageMaintainer{TSDistExtra}
}
\references{
Marteau P. F. (2009) Time Warp Edit Distance with Stiffness Adjustment for Time Series Matching. IEEE Transactions on Pattern Analysis and Machine Intelligence. 31 (2): 306–318. arXiv:cs/0703033. doi:10.1109/TPAMI.2008.76.   

Serrà J., Arcos J.L. (2012) A Competitive Measure to Assess the Similarity between Two Time Series. In: Agudo B.D., Watson I. (eds) Case-Based Reasoning Research and Development. ICCBR 2012. Lecture Notes in Computer Science, vol 7466. Springer, Berlin, Heidelberg.

Silva D.F, Batista G. (2016) Speeding Up All-Pairwise Dynamic Time Warping Matrix Calculation. SDM 2016: 837-845
}
\keyword{ package }
\seealso{
\code{\link[TSdist:TSdist-package]{TSdist}}
}
