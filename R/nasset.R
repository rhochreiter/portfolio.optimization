#' @title Return the number of assets of a portfolio.model
#' 
#' @description
#' \code{n_asset} returns the number of assets of a portfolio.model
#'
#' @param model the portfolio.model to be analysed
#' 
#' @return the number of assets
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
nasset <- n_asset <- function(model) {
  nasset <- NA
  if(model$assets > 0) { nasset <- model$assets }
  return(nasset)
}
