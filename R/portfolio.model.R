#' @title Create a portfolio.model instance (or fix an existing one)
#'
#' @description
#' \code{portfolio.model} creates a new S3 portfolio.model instance or
#' fixes an existing one.
#'
#' @param input model, scenario.set or mean.covariance list
#' 
#' @return an S3 object of class portfolio.model
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @importFrom stats cov
#'
#' @export
portfolio.model <- p.mo <- function(input=NULL) {

  ### Check input
  
  scenario.set <- NULL
  mean.covariance <- NULL
  
  # new or updated model
  new.model <- TRUE
  if('portfolio.model' %in% class(input)) { 
    new.model <- FALSE 
  } else {
    scenario.set <- input
    #!!! check whether it is a mean.cov list
  }

  ### Create the model / initialize 

  # if a new model is to be generated
  if(new.model) { model <- list() }
  
  # (reset) all default values if not set (yet) - in any case
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
  if(!is.null(mean.covariance)) {
    model$asset.means <- mean.covariance$mean
    model$covariance <- mean.covariance$covariance
    model$data <- aux_simulate.scenarios(mean.covariance$mean, mean.covariance$covariance)
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
