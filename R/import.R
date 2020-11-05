#' Import A Dataframe
#'
#' import will import a dataframe from a variety of file formats.
#'
#' @param file path to a file.
#' @param ... additional arguments passed to the function.
#'
#' @export
#' @import vroom readxl tools
#' @importFrom haven read_sas read_stata read_spss
#' @seealso [read_sas()],[read_stata()],[read_spss()],[read_excel()],[vroom()]
#'
#' @return a dataframe
#' @examples
#' \dontrun{
#' import("mtcars.xls")
#' import("mtcars.dta")
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
