#' @title Open a specific portfolio.optimization package tutorial 
#'
#' @description
#' \code{po.tutorial} opens a specific portfolio.optimization package tutorial.
#' If no tutorial is given or the tutorial is missspelled, a list of available
#' tutorials is printed.
#'
#' @param tutorial name of the tutorial to open 
#' 
#' @return Nothing.
#' 
#' @author Ronald Hochreiter, \email{ronald@@algorithmic.finance}
#'
#' @importFrom utils file.edit
#'
#' @export
po.tutorial <- function(tutorial="") {
  tutorials <- c("101")
  tutorial_files <- c("1-po101")
  
  if(!tutorial %in% tutorials) {
    print(paste0("Available tutorials: ", paste(tutorials, collapse=", ")))
  }
  else {
    tutorial_pos <- which(tutorials == tutorial)
    file.edit(paste0(path.package("portfolio.optimization"), "/", tutorial_files[tutorial_pos], ".R"))
  }
}
