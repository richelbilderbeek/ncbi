test_that("use", {
  expect_silent(check_snp_id("1"))
  expect_silent(check_snp_id(42))
  expect_error(check_snp_id(""))
  expect_error(check_snp_id(NULL))
  expect_error(check_snp_id(NA))
  expect_error(check_snp_id(c()))
  expect_error(check_snp_id(character(0)))
  expect_error(check_snp_id(Inf))
  expect_error(check_snp_id(3.14))
})
