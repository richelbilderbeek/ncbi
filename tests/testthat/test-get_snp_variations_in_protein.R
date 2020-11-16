test_that("use, results in protein change", {
  variations <- get_snp_variations_in_protein(snp_id = "1583049783")
  expect_equal(1, length(variations))
  expect_equal("NP_000585.2:p.Gly144Asp", variations)
})

test_that("use, change in DNA, but not in protein", {
  variations <- get_snp_variations_in_protein(snp_id = "1583050033")
  expect_equal(1, length(variations))
  expect_equal("NP_000585.2:p.Leu196=", variations)
})

test_that("use, change in RNA, no protein", {
  variations <- get_snp_variations_in_protein(snp_id = "1583051188")
  expect_equal(0, length(variations))
})

test_that("use, change in DNA, no protein", {
  variations <- get_snp_variations_in_protein(snp_id = "1583051968")
  expect_equal(0, length(variations))
})
