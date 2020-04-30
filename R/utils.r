#' Searches for Latex Beamer template
#'
#' @export
#' @author Sean Brunson

find_file <- function(template, file) {
    template <- system.file("rmarkdown", "templates", template, file,
                            package = "easyresearch")
    if (template == "") {
        stop("Couldn't find template file ", template, "/", file, call. = FALSE)
    }

    template
}

#' Gets Latex Beamer template
#'
#' @export
#' @author Sean Brunson

find_resource <- function(template, file) {
    find_file(template, file.path("resources", file))
}

#' Sets up Latex PDF template
#'
#' @inheritParams rmarkdown::pdf_document
#' @export
#' @author Sean Brunson

inherit_pdf_document <- function(...) {
    fmt <- rmarkdown::pdf_document(...)
    fmt$inherits <- "pdf_document"
    fmt
}

#' Loads anything extra needed in the Latex template
#'
#' @export
#' @author Sean Brunson

load_resources_if_missing <- function(template_name, resources) {
    for (template_file in resources)
        if (!file.exists(template_file))
            file.copy(system.file("rmarkdown", "templates", template_name, "skeleton",
                                  template_file, package = "easyresearch"),
                      ".")
}
