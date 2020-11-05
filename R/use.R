#' Use a package
#'
#' FUNCTION_DESCRIPTION
#'
#' @param pkg A vector containing the name for a package.
#' @export
#'
#' @return the input object is returned silently
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
