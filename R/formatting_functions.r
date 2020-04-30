#' Changes Excel column to comma type
#'
#' @export
#' @author Sean Brunson

as_comma <- function(x){class(x) <- "comma"; x}

#' Changes Excel column to percent type
#'
#' @export
#' @author Sean Brunson

as_percentage <- function(x){class(x) <- "percentage"; x}

#' Changes Excel column to accounting type
#'
#' @export
#' @author Sean Brunson

as_accounting <- function(x){class(x) <- "accounting"; x}

#' Changes data value to comma type for PDF
#'
#' @export
#' @author Sean Brunson

as_comma_pdf <- function(x, digits=2, format="f", ...){
    formatC(as.numeric(x), format = format, digits = digits, big.mark=",")
}

#' Changes data value to percentage type for PDF
#'
#' @export
#' @author Sean Brunson

as_percentage_pdf <- function(x, digits=2, format="f", ...){
    paste0(formatC(100*x, format = format, digits = digits, ...), "%")
}

#' Changes data value to money type for PDF
#'
#' @export
#' @author Sean Brunson

as_money_pdf <- function(x, digits=2, format="f", ...){
    if_negative <- paste0("-$", formatC(abs(as.numeric(x)), format = format,
                                        digits = digits, big.mark=","))
    if_positive <- paste0("$", formatC(as.numeric(x), format = format,
                                       digits = digits, big.mark=","))

    ifelse(as.numeric(x) < 0, if_negative, if_positive)
}
