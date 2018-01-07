context("Testing all functionalities")

test_that("autoplotly works correctly", {
  df <- iris[c(1, 2, 3, 4)]

  a <- autoplotly(prcomp(df), data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)

  # Composable with ggplot
  b <- a + ggplot2::ggtitle("This is a custom title")
})
