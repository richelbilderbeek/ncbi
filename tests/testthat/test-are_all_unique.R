test_that("use", {
  expect_true(are_all_unique(1))
  expect_true(are_all_unique(c(1, 2)))
  expect_false(are_all_unique(c(1, 1)))
  expect_error(are_all_unique(c()))
  expect_error(are_all_unique(NULL))
  expect_error(are_all_unique(NA))
})
