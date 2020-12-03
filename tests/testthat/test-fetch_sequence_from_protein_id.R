test_that("use", {
  Sys.sleep(1)
  sequence <- fetch_sequence_from_protein_id(protein_id = "901695856")
  expect_equal(
    names(sequence),
    "pdb|4ZW9|A Crystal structure of human GLUT3 bound to D-glucose in the outward-occluded conformation at 1.5 angstrom" # nolint indeed a long line
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
