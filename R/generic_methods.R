#' @export
"+.plotly" <- function(p, ggplot_element) {
  ggplot_obj <- p$ggplot_obj + ggplot_element
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
