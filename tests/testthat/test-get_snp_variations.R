test_that("use", {
  variations <- get_snp_variations(snp_id = "1583049783")
  expect_true("NP_000585.2:p.Gly144Asp" %in% variations)
})

test_that("use", {
  variations <- get_snp_variations(snp_id = "1466623805")
  expect_equal(length(variations), 0)
})

test_that("allow to input a number that is converted to scientific format", {
  expect_silent(get_snp_variations(snp_id = 1596000000))

  # Scientific notation is converted to 1596000000
  expect_silent(get_snp_variations(snp_id = 1.596e+09))
  expect_message(
    get_snp_variations(snp_id = 1.596e+09, verbose = TRUE),
    "url.*1596000000"
  )
})
