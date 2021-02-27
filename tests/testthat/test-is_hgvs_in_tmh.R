test_that("use", {
  expect_false(is_hgvs_in_tmh(hgvs = "NP_000585.2:p.Gly144Asp"))
})

test_that("use", {
  expect_error(
    is_hgvs_in_tmh("NP_000585.2:p.Leu196="),
    "Variation 'NP_000585.2:p.Leu196=' does not change an amino acid"
  )
})
