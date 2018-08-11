#' @title Return the number of scenarios of a portfolio.model
#' 
#' @description
#' \code{n_scenario} returns the number of scenarios of a portfolio.model
#'
#' @param model the portfolio.model to be analysed
#' 
#' @return the number of scenarios
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
nscenario <- n_scenario <- function(model) {
  nscenario <- NA
  if(model$scenarios > 0) { nscenario <- model$scenarios }
  return(nscenario)
}
