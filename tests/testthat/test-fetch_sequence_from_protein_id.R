test_that("use", {
  Sys.sleep(1)
  sequence <- fetch_sequence_from_protein_id(protein_id = "901695856")
  expect_equal(
    names(sequence),
    "pdb|4ZW9|A Chain A, Solute carrier family 2, facilitated glucose transporter member 3" # nolint indeed a long line
  )
  regexp <- paste0("[", paste0(Peptides::aaList(), collapse = ""), "]+")
  expect_match(
    sequence,
    regexp = regexp
  )
})

test_that("verbose error", {
  Sys.sleep(1)
  expect_error(
    fetch_sequence_from_protein_id(
      protein_id = "NP_123.4"
    )
  )
})
