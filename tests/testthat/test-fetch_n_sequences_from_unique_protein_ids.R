test_that("use", {
  protein_ids_filename <- system.file(
    "extdata", "protein_ids.csv", package = "ncbi"
  )
  all_protein_ids <- readr::read_csv(
    protein_ids_filename,
    col_types = readr::cols(protein_id = readr::col_character())
  )$protein_id

  max_n_protein_ids <- 2
  protein_ids <- sample(
    x = unique(all_protein_ids),
    size = max_n_protein_ids,
    replace = FALSE
  )
  expect_true(are_all_unique(protein_ids))

  sequences <- fetch_n_sequences_from_unique_protein_ids(
    protein_ids = protein_ids,
    max_n_protein_ids = max_n_protein_ids
  )
  expect_equal(length(protein_ids), length(sequences))
})

test_that("limit the number of proteins", {
  protein_ids_filename <- system.file(
    "extdata", "protein_ids.csv", package = "ncbi"
  )
  protein_ids <- readr::read_csv(
    protein_ids_filename,
    col_types = readr::cols(protein_id = readr::col_character())
  )$protein_id

  expect_error(
    fetch_n_sequences_from_unique_protein_ids(
      protein_ids = protein_ids
    ),
    "Too many protein IDs"
  )
})

test_that("all proteins must be unique", {
  expect_error(
    fetch_n_sequences_from_unique_protein_ids(
      protein_ids = rep("XP_011529113.1", 2)
    ),
    "All protein IDs must be unique"
  )
})
