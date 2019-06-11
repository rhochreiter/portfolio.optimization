#' @title Set a minimum mean value (lower bound)
#' 
#' @description
#' \code{min.mean} adds a minimum mean constraint to the model
#'
#' @param model the portfolio.model to add a minimum mean constraint
#' @param value the minimum mean constraint value
#' 
#' @return portfolio.model with minimum mean constraint enabled
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export min.mean
min.mean <- function(model, value) {  
  model$fix.mean <- NULL
  model$min.mean <- value
  return(model)
}
