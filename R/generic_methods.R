#' @export
"+.plotly" <- function(p, ggplot_element) {
  ggplot_obj <- tryCatch(
    p$ggplot_obj + ggplot_element,
    # Slightly better error message
    error = function(e) {
      if (grepl("Don't know how to add", e$message)) {
        stop("You are not using ggplot2 syntax correctly.",
             "Please visit http://ggplot2.tidyverse.org/index.html for more tutorials.")
      }
    }
  )
  autoplotly(ggplot_obj)
}

#' @title Automatic Visualization of Popular Statistical Results Using plotly and ggplot2
#' @description This function provides functionality to automatically generate interactive
#' plot for many popular statistical results supported by `ggfortify` package using plotly and ggplot2.
#'
#' @inheritParams autoplotly.default
#' @export
autoplotly <- function(object,
                       ...,
                       width = NULL,
                       height = NULL,
                       tooltip = "all",
                       dynamicTicks = FALSE,
                       layerData = 1,
                       originalData = TRUE,
                       source = "A") {
  UseMethod("autoplotly")
}
