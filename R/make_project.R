#' @title create a project
#' @description
#' Creates a new project and sets up all of the relevant directories and their initial contents.
#'
#' @param project A character string containing the name for this new project.
#' @param path An optional character string containing the path for this new project. By default, the path is set to the current directory.
#' @param folders An optional character vector containing the names of the subdirectories. By default, the project will contain only five subdirectories with default names.
#' @param readme An optional character string containing the name of the readme file. By default, the name of the readme file will be "README.md".
#' @param git An optional boolean value indicating whether the project files should be committed to Github (\code{TRUE}) or not (\code{FALSE}). Default is \code{FALSE}.
#'
#' @details
#' This function creates a new project and sets up all of the relevant directories and their initial contents. If the path of
#' the project is not specified, the path will be set to the current directory. The default behavior is to add 5 essential
#' subdirectories, but it is also possible to specify or add your own subdirectories. \code{make_project} also creates
#' a readme file called "README.md" by default. You can specify the name of the readme file. The project files
#' will be commited to Github if \code{git = TRUE}, however, the default is \code{FALSE}.
#'
#' @return No value is returned (this function is called for its side effects.)
#' @import usethis
#' @export
#'
#' @examples
#' \dontrun{
#' make_project("newproject")
#'
#' # provide a custom path for the project.
#' make_project("newproject", path = "path/to/new-project")
#'
#' # automatically commit the new project files to Github
#'
#' make_project("secondproject", git = TRUE)
#'}
make_project <- function (project,
                  path = getwd(),
                  folders = c("figures", "documentation",
                              "data", "reports", "R"),
                  readme = "README.md",
                  git = FALSE) {


  # change to path location
  if(!dir.exists(path)) stop("No such path")
  setwd(path)

  # project directory
  if(!missing(project)) {
    dir.create(project)
    setwd(project)
  }

  # create subdirectories
  for (i in folders){
    dir.create(i)
  }


  # create README.md
  today <- Sys.Date()
  user  <- Sys.info()[["user"]]
  project <- basename(getwd())
  cat("# Project: ", project, "\n\n",
      "## Author: ", user, "\n\n",
      "## Date: ",   format(today, format="%B %d %Y"), "\n\n",
      "## Purpose: \n\n",
      "## Data Sources: \n\n",
      "## Stakeholders: \n\n",
      file = readme,
      sep = "")

  # create RStudio project
  usethis::create_project(".", open=FALSE)

  # add git
  if (git){
     usethis::use_git()
  }


  # activate project
  usethis::proj_activate(".")

}
