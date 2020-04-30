#' Function to make plots as minimum as possible
#'
#' @export
#' @author Sean Brunson

make_minimum_background <- function(){
    theme_bw() +
        theme(panel.border = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              axis.line = element_line(colour = "black"))
}

#' Function to make plot of a map pretty
#'
#' @export
#' @author Sean Brunson
theme_map <- function(...){
    make_minimum_background() +
        theme(text = element_text(color = "#22211d"),
              axis.line = element_blank(),
              axis.text.x = element_blank(),
              axis.text.y = element_blank(),
              axis.ticks = element_blank(),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              panel.grid.minor = element_blank(),
              panel.border = element_blank(),
              ...)
}

#' Function to adjust x and y axis of ggplot2 plot
#'
#' Makes sure that limits are above or below highest and lowest value respectively
#' @export
#' @author Sean Brunson

adjust_limits <- function(lower_bound, upper_bound, lower_bound_change = 0.1,
                          upper_bound_change = 0.1){
    final_lower_bound <- lower_bound * (1 + lower_bound_change)

    if(upper_bound < 0){
        final_upper_bound <- upper_bound * (1 - upper_bound_change)
    } else{
        final_upper_bound <- upper_bound * (1 + upper_bound_change)
    }

    c(final_lower_bound, final_upper_bound)
}

color_set <- c(red = "#F8766D",
               green = "springgreen3",
               blue = "deepskyblue2",
               orange = "#DE8C00",
               yellow = "#ffc425",
               purple = "#C374FF",
               light_grey = "#CACACA",
               medium_grey = "#676767",
               dark_grey = "grey1",
               brown = "rosybrown4")

#' Setup color names
#'
#' @export
#' @author Sean Brunson

color_set_names <- function(...){
    cols <- c(...)

    if(is.null(cols))
        return(color_set)

    color_set[cols]
}

color_palettes <- list(three_color = color_set_names("blue", "red", "brown"),
                       two_color = color_set_names("blue", "red"),
                       two_color2 = color_set_names("blue", "brown"),
                       boring_two = color_set_names("light_grey", "blue"),
                       boring_three = color_set_names("light_grey", "red", "blue"),
                       three_greys = color_set_names("light_grey", "medium_grey",
                                                     "dark_grey"))

#' Setup color palette
#'
#' @export
#' @author Sean Brunson

palette_choice <- function(palette = "three_color", reverse = FALSE, ...){
    pal <- color_palettes[[palette]]

    if(reverse) pal <- rev(pal)

    colorRampPalette(pal, ...)
}

#' Function to create own color lines
#'
#' @inheritParams ggplot2::discrete_scale
#' @export
#' @author Sean Brunson

scale_color_special <- function(palette = "three_color", discrete = TRUE,
                                reverse = FALSE, ...){
    pal <- palette_choice(palette = palette, reverse = reverse)

    if(discrete){
        discrete_scale("colour", paste0("color_", palette), palette = pal, ...)
    } else{
        scale_color_gradient(colours = pal(256), ...)
    }
}

#' Function to create own color fill columns
#'
#' @inheritParams ggplot2::discrete_scale
#' @export
#' @author Sean Brunson

scale_fill_special <- function(palette = "three_color", discrete = TRUE,
                               reverse = FALSE, ...){
    pal <- palette_choice(palette = palette, reverse = reverse)

    if(discrete){
        discrete_scale("fill", paste0("color_", palette), palette = pal, ...)
    } else{
        scale_fill_gradient(colours = pal(256), ...)
    }
}
