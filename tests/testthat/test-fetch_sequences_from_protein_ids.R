test_that("use", {
  Sys.sleep(1)

  protein_ids <- c(
    "NP_009089.4",
    "NP_001007554.1",
    "NP_001123995.1",
    "NP_001229820.1",
    "NP_001229821.1",
    "NP_001229822.1"
  )
  sequences <- fetch_sequences_from_protein_ids(protein_ids = protein_ids)
  expect_equal(
    length(sequences),
    length(protein_ids)
  )
  regexp <- paste0(
    "[",
    paste0(Peptides::aaList(), collapse = ""),
    "]+"
  )
  expect_equal(
    length(protein_ids),
    sum(stringr::str_count(sequences, regexp))
  )
})
