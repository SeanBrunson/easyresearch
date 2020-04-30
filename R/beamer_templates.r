#' "Charlotte" (UNCC) Themed Beamer Presentation Template for RMarkdown
#'
#' Generates from a RMarkdown file a Beamer presentation with "Charlotte" (UNCC)
#' colors and identity standards.
#' @inheritParams rmarkdown::beamer_presentation
#' @return A modified \code{beamer_presentation} based on the "Charlotte" (UNCC)
#'  Beamer themed template.
#' @export
#' @author RStudio RMarkdown Team (Everything) & Sean Brunson (Theme hook + Beamer Theme)

beamer_uncc <- function(toc = FALSE,
                        slide_level = 3,
                        incremental = FALSE,
                        fig_width = 17,
                        fig_height = 10,
                        fig_crop = TRUE,
                        fig_caption = TRUE,
                        dev = 'pdf',
                        df_print = "default",
                        fonttheme = "default",
                        highlight = "default",
                        keep_tex = FALSE,
                        latex_engine = "pdflatex",
                        citation_package = c("none", "natbib", "biblatex"),
                        includes = NULL,
                        md_extensions = NULL,
                        pandoc_args = NULL){

    template <- find_resource("beamer_uncc", "template.tex")

    load_resources_if_missing("beamer_uncc", c("uncc_belk.pdf"))

    rmarkdown::beamer_presentation(template = template,
                                   toc = toc,
                                   slide_level = slide_level,
                                   incremental = incremental,
                                   fig_width = fig_width,
                                   fig_height = fig_height,
                                   fig_crop = fig_crop,
                                   fig_caption = fig_caption,
                                   dev = dev,
                                   df_print = df_print,
                                   fonttheme = fonttheme,
                                   highlight = highlight,
                                   keep_tex = keep_tex,
                                   latex_engine = latex_engine,
                                   citation_package = citation_package,
                                   includes = includes,
                                   md_extensions = md_extensions,
                                   pandoc_args = pandoc_args)
}
