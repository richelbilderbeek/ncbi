test_that("use", {
  variations <- get_snp_variations(snp_id = "1583049783")
  expect_true("NP_000585.2:p.Gly144Asp" %in% variations)
})

test_that("use", {
  variations <- get_snp_variations(snp_id = "1466623805")
  expect_equal(length(variations), 0)
})
