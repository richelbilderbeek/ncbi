#' Fetch the sequence from one or more protein ID
#'
#' Fetch the protein sequence using one or more protein IDs
#' @inheritParams default_params_doc
#' @return a character vector with protein sequences,
#'   one per protein ID
#' @export
fetch_sequences_from_protein_ids <- function( # nolint indeed a long function name
  protein_ids,
  chunk_size = 100,
  verbose = FALSE
) {
  t_1 <- tibble::tibble(
    protein_id = protein_ids
  )
  t_2 <- tibble::tibble(
    protein_id = unique(protein_ids),
    sequence = NA
  )
  t_2$sequence <- fetch_sequences_from_unique_protein_ids(
    protein_ids = t_2$protein_id,
    chunk_size = chunk_size,
    verbose = verbose
  )
  t_3 <- dplyr::left_join(t_1, t_2, by = "protein_id")

  # Protein IDs are preserved
  testthat::expect_equal(
    t_1$protein_id,
    t_3$protein_id
  )
  t_3$sequence
}
