test_that("it works", {
  skip_on_cran()
  result <- duckduck_answer("ggplot", app_name = "duckduckr_development")
  expect_true(is.list(result))
  expect_true(length(result) > 0)
})
