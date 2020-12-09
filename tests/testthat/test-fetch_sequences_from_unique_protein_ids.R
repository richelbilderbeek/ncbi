test_that("process 3 protein IDs in 2 chunks of 2", {
  protein_ids_filename <- system.file(
    "extdata", "protein_ids.csv", package = "ncbi"
  )
  all_protein_ids <- readr::read_csv(
    protein_ids_filename,
    col_types = readr::cols(protein_id = readr::col_character())
  )$protein_id

  protein_ids <- sample(
    x = unique(all_protein_ids),
    size = 3,
    replace = FALSE
  )
  expect_true(are_all_unique(protein_ids))

  chunk_size <- 2
  sequences <- fetch_sequences_from_unique_protein_ids(
    protein_ids = protein_ids,
    chunk_size = chunk_size
  )
  expect_equal(length(protein_ids), length(sequences))
  expect_equal(0, sum(is.na(sequences)))
})

test_that("all proteins must be unique", {
  expect_error(
    fetch_sequences_from_unique_protein_ids(
      protein_ids = rep("XP_011529113.1", 2)
    ),
    "All protein IDs must be unique"
  )
})
