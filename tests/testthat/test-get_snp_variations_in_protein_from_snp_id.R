test_that("use, results in protein change", {
  variations <- get_snp_variations_in_protein_from_snp_id(snp_id = "1583049783")
  expect_equal(1, length(variations))
  expect_equal("NP_000585.2:p.Gly144Asp", variations)
})

test_that("use, change in DNA, but not in protein", {
  variations <- get_snp_variations_in_protein_from_snp_id(snp_id = "1583050033")
  expect_equal(1, length(variations))
  expect_equal("NP_000585.2:p.Leu196=", variations)
})

test_that("use, change in RNA, no protein", {
  variations <- get_snp_variations_in_protein_from_snp_id(snp_id = "1583051188")
  expect_equal(0, length(variations))
})

test_that("use, change in DNA, no protein", {
  variations <- get_snp_variations_in_protein_from_snp_id(snp_id = "1583051968")
  expect_equal(0, length(variations))
})

test_that("allow to input a number that is converted to scientific format", {
  expect_silent(get_snp_variations_in_protein_from_snp_id(snp_id = 1596000000))
  expect_silent(get_snp_variations_in_protein_from_snp_id(snp_id = 1.596e+09))
})

test_that("abuse", {
  expect_error(
    get_snp_variations_in_protein_from_snp_id(
      c("1", "2")
    )
  )
})
