TWEDistance <- function(X, Y, Xts=NULL, Yts = NULL, nu = 0.001, lambda = 1.0, degree = 2) {
  if (is.null(Xts))
    Xts <- 1:length(X)
  if (is.null(Yts))
    Yts <- 1:length(Y)
  .Call('_TSDistExtra_TWEDistance', PACKAGE = 'TSDistExtra', X, Xts, Y, Yts, nu, lambda, degree)
}

MJCDistance <- function(X, Y, beta = 2) {
  .Call('_TSDistExtra_MJCDistance', PACKAGE = 'TSDistExtra', X, Y, beta)
}

PrunedDTWDistance <- function(X, Y, window = 1) {
  .Call('_TSDistExtra_PrunedDTWDistance', PACKAGE = 'TSDistExtra', X, Y, window)
}