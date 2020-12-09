
#' Fetch the sequence from one or more protein ID
#'
#' Fetch the protein sequence using one or more protein IDs
#' @inheritParams default_params_doc
#' @return a character vector with protein sequences,
#'   one per protein ID
#' @export
fetch_sequences_from_unique_protein_ids <- function( # nolint indeed a long function name
  protein_ids,
  chunk_size = 100,
  verbose = FALSE
) {
  if (!ncbi::are_all_unique(protein_ids)) {
    stop("All protein IDs must be unique")
  }
  n_protein_ids <- length(protein_ids)
  sequences <- rep(NA, n_protein_ids)

  # Create a table of indeces
  t_indices <- tibble::tibble(
    from = seq(from = 1, to = n_protein_ids, by = chunk_size)
  )
  t_indices$to <- t_indices$from + chunk_size - 1
  t_indices$to[nrow(t_indices)] <- n_protein_ids

  for (i in seq_len(nrow(t_indices))) {
    from <- t_indices$from[i]
    to <- t_indices$to[i]
    sequences[from:to] <- ncbi::fetch_n_sequences_from_unique_protein_ids(
      protein_ids[from:to]
    )
  }
  testthat::expect_equal(length(protein_ids), length(sequences))
  testthat::expect_equal(0, sum(is.na(sequences)))
  sequences
}
