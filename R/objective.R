#' @title Set new objective of a portfolio.model
#' 
#' @description
#' \code{objective} sets a new objective for VaR and Expected Shortfall
#'
#' @param model the portfolio.model to be changed
#' @param objective the new objective
#' 
#' @return the adapted portfolio.model
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
objective <- function(model, objective="markowitz") {
  
  # check if selected objective is supported
  supported_objectives <- list("markowitz", "sd", "standard.deviation", "variance"
                               # ,
                               # "reward", "1overN", "momentum", 
                               # "mad",
                               # "expected.shortfall", "cvar", "avar"
                               )

  # if not, fall back to markowitz
  if (!(objective %in% supported_objectives)) {
    warning("Selected objective is not supported! Falling back to objective: markowitz")
    objective <- "markowitz"
  }
  
  # alias handling
  if (objective == "sd") { objective <- "markowitz" }
  if (objective == "standard.deviation") { objective <- "markowitz" }
  if (objective == "variance") { objective <- "markowitz" }
  
  if (objective == "cvar") { objective <- "expected.shortfall" }
  if (objective == "avar") { objective <- "expected.shortfall" }

  # set objective and return model
  model$objective <- objective
  return(model)
}
