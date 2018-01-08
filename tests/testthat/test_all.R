context("Testing all functionalities")

df <- iris[c(1, 2, 3, 4)]
result <- prcomp(df)

test_that("autoplotly works correctly", {
  p <- autoplotly(result, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)
  expect_true(inherits(p, "plotly"))
  expect_true(inherits(p$ggplot_obj, "ggplot"))
})

test_that("autoplotly is composable with additional ggplot2 elements", {
  p <- autoplotly(result, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)
  p <- p + ggplot2::ggtitle("This is a custom title") + ggplot2::labs(y = "Second Principal Components", x = "First Principal Components")
  expect_true(inherits(p, "plotly"))
  expect_true(inherits(p$ggplot_obj, "ggplot"))
})

test_that("Errors are thrown when class is not supported by ggfortify", {
  a <- 1
  class(a) <- "None"
  expect_error(autoplotly(a, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE), "Only object of the following classes are supported for autoplotly")
})

test_that("autoplotly accepts additional plotly args", {
  p <- autoplotly(result, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE,
                  tooltip = "all", dynamicTicks = FALSE, layerData = 1, originalData = TRUE, source = "A")
  expect_true(inherits(p, "plotly"))
  expect_true(inherits(p$ggplot_obj, "ggplot"))
})
