#' @title Simulate a multivariate-normal scenario.set 
#'
#' @description
#' \code{portfolio.model} simulates a scenario.set given a mean vector and
#' a covariance matrix using mvrnorm of the MASS package
#'
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
aux.simulate.scenarios <- function(mu, Sigma, n=1000) {
  simulation <- MASS::mvrnorm(n, mu, Sigma)
  
}
