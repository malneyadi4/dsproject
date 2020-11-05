#' @title check, install and load a package
#' @description
#' Checks the local R libraries to see if the required package is installed or not.
#' If the package is not installed, the user will be prompted to choose whether to
#' install the package or not. If the user chose to install the package,
#' it will be first installed and then loaded.
#'
#' @param pkg the name of a package, given as a name or a character string.
#' @export
#'
#' @details
#' This function checks the local R libraries to see if the required package is installed or not.
#' If the package is not installed, then the user will be prompted to choose whether to
#' install the package or not. If the user said yes, the package will be installed along with
#' the required dependencies. After that, the package will be loaded.
#'
#' @return the input object (attached package) is returned invisibly
#' @examples
#' \dontrun{
#' use(dplyr)
#' use(ggplot2)
#'}
use <- function(pkg) {
  pkg <- as.character(substitute(pkg))
  if (!suppressWarnings(require(pkg, character.only = TRUE))) {
    msg <- paste("Install package", pkg, "(y/n)? ")
    answer <- readline(msg)
    answer <- substr(tolower(trimws(answer)), 1, 1)
    if (answer == "y") {
      install.packages(pkg)
      require(pkg, character.only = TRUE)
    } else {
      msg <- paste("Package", pkg, "not loaded.")
      message(msg)
    }
  }
}
