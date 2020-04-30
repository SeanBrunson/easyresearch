#' Compiles Paper
#'
#' Compiles index.Rmd file in main directory of project to write paper
#'
#' @param full Creates full paper if true or just results if false
#' @export
#' @author Sean Brunson

compile_paper <- function(full = TRUE){
    if(full == TRUE){
        bookdown::render_book("index.Rmd", config_file = "paper/_bookdown.yml",
                              output_dir = "paper/_book")
    } else{
        bookdown::render_book("index.Rmd", config_file = "paper/_bookdown2.yml",
                              output_dir = "paper/_book")
    }
}
