#' @export
autoplotly.default <- function(
  object,
  ...,
  width = NULL,
  height = NULL,
  tooltip = "all",
  dynamicTicks = FALSE,
  layerData = 1,
  originalData = TRUE,
  source = "A") {

  autoplot_methods <- gsub("autoplot.", "", grep("autoplot.", ls(getNamespace("ggfortify")), value = TRUE))
  if (!any(class(object) %in% autoplot_methods)) {
    stop(paste0(
      "Only object of the following classes are supported for autoplotly: ",
      paste0(autoplot_methods, collapse = ", ")))
  }
  ggplot_obj <- autoplot(object, ...)
  plotly_obj <- ggplotly(
    ggplot_obj,
    width = width,
    height = height,
    tooltip = tooltip,
    dynamicTicks = dynamicTicks,
    layerData = layerData,
    originalData = originalData, source = source)
  plotly_obj$ggplot_obj <- ggplot_obj
  plotly_obj
}
