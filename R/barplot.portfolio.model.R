#' @title Overload barplot() for portfolio.model
#' 
#' @description
#' \code{barplot.portfolio.model} overloads barplot() and plots the portfolio
#' weights of the given model
#'
#' @param model the portfolio.model to plot the portfolio weights from
#' 
#' @return nothing
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
barplot.portfolio.model <- function(model) {
  labels <- names(model$data)[which(model$portfolio$x == 0)]
  labels[which(model$portfolio$x == 0)] <- NA
  barplot(las=3, model$portfolio$x[which(model$portfolio$x > 0)], 
          names.arg=names(model$data)[which(model$portfolio$x > 0)], 
          col=topo.colors(1)) 
}
