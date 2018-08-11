#' @title Overload print() for portfolio.model
#' 
#' @description
#' \code{print.portfolio.model} overloads print() and outputs some information
#' about the portfolio.model object
#'
#' @param model the portfolio.model to display
#' 
#' @return nothing
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
print.portfolio.model <- function(model) {
  # currently only basic information
  cat("Portfolio Optimization model\n\n")  
  cat("- Objective:", model$objective, "\n")
  cat("- Scenarios:", model$scenarios, "\n")
  cat("- Assets:", model$assets, "\n")
}
