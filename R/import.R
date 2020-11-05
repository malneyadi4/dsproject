#' @title import
#' @description
#' Imports a data frame from a data file with the file format based on the file extension
#'
#' @param file An optional character string naming a path to a file. By default, the user will be prompted to choose a file.
#' @param ... additional arguments passed to the function.
#'
#' @details
#' This function imports a data frame from a data file with the file format based on the file extension.
#' \code{import} supports a variety of file extensions including SAS (.sas7bdat), Stata (.dta), SPSS (.sav), Excel (.xls and .xlsx), Comma-separated data (.csv), and Tab-separated data (.tsv).
#' If the file path is not specified, \code{import} will prompt the user to choose a file.
#'
#' @return A Dataframe
#' @import vroom readxl tools
#' @importFrom haven read_sas read_stata read_spss
#' @export
#'
#' @seealso [\code{read_spss}](https://www.rdocumentation.org/packages/haven/versions/2.3.1/topics/read_spss),[\code{read_excel}](https://www.rdocumentation.org/packages/readxl/versions/1.3.1/topics/read_excel),[\code{vroom}](https://www.rdocumentation.org/packages/vroom/versions/1.0.2/topics/vroom),[\code{read_sas}](https://www.rdocumentation.org/packages/haven/versions/2.3.1/topics/read_dta)
#' @examples
#' \dontrun{
#' # import XLS or SAV as a `data.frame`
#' df = import("mtcars.xls")
#' df = import("mtcars.sav")
#'
#' # pass arguments to underlying import function
#' df = import("mtcars.dta",nmax = 5)
#'}
import <- function(file, ...){

  # if no file specified, prompt user

  if(missing(file))
    file <- file.choose()


  # get file info

  file <- tolower(file)
  basename <- basename(file)
  extension <- tools::file_ext(file)


  # import dataset

  df <- switch(extension,
           "sas7bdat" = haven::read_sas(file, ...),
           "dta" = haven::read_stata(file, ...),
           "sav" = haven::read_spss(file, ...),
           "xlsx" = readxl::read_excel(file, ...),
           "xls" = readxl::read_excel(file, ...),
           vroom::vroom(file, ...)
           )

  # return data frame
  return(df)
}
