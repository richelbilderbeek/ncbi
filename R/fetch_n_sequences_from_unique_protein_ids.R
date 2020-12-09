#' Fetch the n sequence from one or more unique protein ID
#'
#' Fetch the n sequence from one or more unique protein ID,
#' where n is the maximum number of sequences NCBI allows for
#' @inheritParams default_params_doc
#' @param max_n_protein_ids the maximum number of protein IDs
#' @return a character vector with protein sequences,
#'   one per protein ID
#' @export
fetch_n_sequences_from_unique_protein_ids <- function( # nolint indeed a long function name
  protein_ids,
  max_n_protein_ids = 100,
  verbose = FALSE
) {
  if (length(protein_ids) > max_n_protein_ids) {
    stop(
      "Too many protein IDs. ",
      "Number of protein IDs: ", length(protein_ids),
      "Maximum number of protein IDs: ", max_n_protein_ids
    )
  }
  if (!ncbi::are_all_unique(protein_ids)) {
    stop("All protein IDs must be unique")
  }
  fasta_raw <- NA
  tryCatch({
    fasta_raw <- rentrez::entrez_fetch(
      id = protein_ids,
      db = "protein",
      rettype = "fasta",
      config = httr::config(verbose = verbose)
    )
    }, error = function(e) {
      stop(
        "Error for protein IDs (showing head) '",
        paste0(utils::head(protein_ids), collapse = " "), "':\n",
        e

      )
    }
  )
  fasta_filename <- tempfile()
  readr::write_lines(x = fasta_raw, file = fasta_filename)
  t <- pureseqtmr::load_fasta_file_as_tibble(fasta_filename = fasta_filename)
  seqs <- t$sequence
  names(seqs) <- t$name
  seqs
}

