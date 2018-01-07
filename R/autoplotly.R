#' Automatic Visualization Using plotly and ggplot2
#'
#' @export
autoplotly.default <- function(object, ...) {
  ggplot_obj <- autoplot(object, ...)
  plotly_obj <- ggplotly(ggplot_obj)
  plotly_obj$ggplot_obj <- ggplot_obj
  plotly_obj
}
