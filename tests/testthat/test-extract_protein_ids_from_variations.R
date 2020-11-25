test_that("use", {
  variations <- c(
    "NP_009089.4:p.Val723Gly",
    "NP_001007554.1:p.Val754Gly",
    "NP_001123995.1:p.Val769Gly",
    "NP_001229820.1:p.Val800Gly",
    "NP_001229821.1:p.Val754Gly",
    "NP_001229822.1:p.Val723Gly"
  )
  protein_ids <- extract_protein_ids_from_variations(variations)
  expected_protein_ids <- c(
    "NP_009089.4",
    "NP_001007554.1",
    "NP_001123995.1",
    "NP_001229820.1",
    "NP_001229821.1",
    "NP_001229822.1"
  )
  expect_equal(expected_protein_ids, protein_ids)
})
