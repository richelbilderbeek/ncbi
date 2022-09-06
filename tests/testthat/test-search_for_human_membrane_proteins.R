test_that("use", {
  Sys.sleep(16)
  ids <- search_for_human_membrane_proteins()
  expect_true(is.character(ids))
  expect_true(length(ids) > 0)
})
