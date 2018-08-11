#' @title Set new alpha of a portfolio.model
#' 
#' @description
#' \code{alpha} sets a new alpha for VaR and Expected Shortfall
#'
#' @param model the portfolio.model to be changed
#' @param alpha the value alpha (between 0 and 1)
#' 
#' @return the adapted portfolio.model
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
alpha <- function(model, alpha) {
  # check alpha
  if ((alpha < 0) | (alpha > 1)) { 
    warning("Invalid alpha chosen, switching back to 95%")
    alpha <- 0.05 
  }
  
  # set alpha and return model
  model$alpha <- alpha
  return(model)
}
