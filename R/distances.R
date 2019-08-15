TWEDistance <- function(X, Y, Xts=NULL, Yts = NULL, nu = 0.001, lambda = 1.0, degree = 2) {
  if (is.null(Xts))
    Xts <- 1:length(X)
  if (is.null(Yts))
    Yts <- 1:length(Y)
  .Call('_TSDistExtra_TWEDistance', PACKAGE = 'TSDistExtra', X, Xts, Y, Yts, nu, lambda, degree)
}
