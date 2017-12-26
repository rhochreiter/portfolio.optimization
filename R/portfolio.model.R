#' @title Create a portfolio.model instance (or fix an existing one)
#'
#' @description
#' \code{portfolio.model} creates a new S3 portfolio.model instance or
#' fixes an existing one.
#'
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @export
portfolio.model <- function(model=NULL, scenario.set=NULL, mean.covariance=NULL, parameter=NULL) {

  # check input
  if(is.null(scenario.set) & is.null(mean.covariance)) { }
  if(!is.null(scenario.set) & !is.null(mean.covariance)) { 
    warning("Both scenario.set and covariance assigned - using scenario.set only!")
    mean.covariance <- NULL
  }
  
  # extract mean vector and covariance matrix
  if(!is.null(mean.covariance)) {
    mu <- mean.covariance$mean
    covariance <- mean.covariance$covariance
  }

  # initialize a new portfolio.model if no model given
  if(is.null(scenario.set)) { model <- list() }
  
  # (reset) default values if not set
  if(!("objective" %in% names(model))) model$objective <- "markowitz"
  if(!("precision" %in% names(model))) model$precision <- 8
  if(!("active.extension" %in% names(model))) model$active.extension <- FALSE
  if(!("sum.portfolio" %in% names(model))) model$sum.portfolio <- 1
  if(!("alpha" %in% names(model))) model$alpha <- 0.05
  if(!("min.mean" %in% names(model))) model$min.mean <- NULL
  if(!("max.mean" %in% names(model))) model$max.mean <- NULL
  if(!("fix.mean" %in% names(model))) model$fix.mean <- NULL
  if(!("sum.long" %in% names(model))) model$sum.long <- NULL
  if(!("sum.short" %in% names(model))) model$sum.short <- NULL
  if(!("momentum.long" %in% names(model))) model$momentum.long <- NULL
  if(!("momentum.short" %in% names(model))) model$momentum.short <- NULL
  
  # default values - scenario.set
  if(!is.null(scenario.set)) {
    model$data <- scenario.set
    model$assets <- dim(scenario.set)[2]
    model$scenarios <- dim(scenario.set)[1]
    model$scenario.probabilities <- rep(1/model$scenarios, model$scenarios)
    model$asset.means <- as.vector(apply(scenario.set, 2, mean))
    model$covariance <- cov(scenario.set)
  }
  
  # default values - covariance
  if(!is.null(covariance)) {
    model$asset.means <- mu
    model$covariance <- covariance
    model$data <- aux.simulate.scenarios(mu, covariance)
    model$assets <- dim(scenario.set)[2]
    model$scenarios <- dim(scenario.set)[1]
    model$scenario.probabilities <- rep(1/model$scenarios, model$scenarios)
  }
  
  # set upper bounds according to asset structure
  model$asset.bound.lower <- rep(0, model$assets)
  model$asset.bound.upper <- rep(1, model$assets)
  
  # default values - portfolio, reset anyways
  model$portfolio <- NA
  
  # return S3 class instance of type portfolio.model
  class(model) <- "portfolio.model"  
  return(model)
}
