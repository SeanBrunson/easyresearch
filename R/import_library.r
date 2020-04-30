#' Import Library
#'
#' Suppresses messages and warnings when importing libraries
#'
#' @export
#' @author Sean Brunson

import_library <- function(lib_name){
    suppressWarnings(suppressMessages(require(lib_name, character.only = TRUE)))
}
