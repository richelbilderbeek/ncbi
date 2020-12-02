#' Fetch the sequence from a protein ID
#'
#' Fetch the protein sequence using a protein ID
#' @inheritParams default_params_doc
#' @return text that can be saved as a FASTA file
#' @export
fetch_sequences_from_subject_ids <- function( # nolint keep long descriptive function name
  subject_ids,
  verbose = FALSE
) {
  fasta_raw <- rentrez::entrez_fetch(
    id = subject_ids,
    db = "protein",
    rettype = "fasta",
    config = httr::config(verbose = verbose)
  )
  fasta_text <- stringr::str_split(fasta_raw, pattern = "\n")[[1]]
  fasta_text <- fasta_text[fasta_text != ""]
  fasta_text
}
