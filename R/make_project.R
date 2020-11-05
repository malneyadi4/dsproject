#' Create A New Project
#'
#' make_project will create a new project
#'
#' @param project A character vector containing the name for this new project.
#' @param path Set the path of the new project to the current directory.
#' @param folders Set the names of the subdirectories in the new project.
#' @param readme Set the name and format of the readme file in the new project.
#' @param git Add git if true.
#'
#' @export
#' @import usethis
#'
#' @return a project
#' @examples
#' \dontrun{
#' make_project("firstproject")
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
