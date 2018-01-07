#' @export
"+.plotly" <- function(p, ggplot_element) {
  ggplot_obj <- p$ggplot_obj + ggplot_element
  autoplotly(ggplot_obj)
}

#' @export
autoplotly <- function(object, ...) {
  UseMethod("autoplotly")
}
