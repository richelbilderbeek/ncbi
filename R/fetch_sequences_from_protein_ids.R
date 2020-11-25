#' Fetch the sequence from one or more protein ID
#'
#' Fetch the protein sequence using one or more protein IDs
#' @inheritParams default_params_doc
#' @return a character vector with protein sequences,
#'   one per protein ID
#' @export
fetch_sequences_from_protein_ids <- function(protein_ids) {
  fasta_raw <- rentrez::entrez_fetch(
    id = protein_ids,
    db = "protein",
    rettype = "fasta"
  )
  fasta_filename <- tempfile()
  readr::write_lines(x = fasta_raw, file = fasta_filename)
  t <- tmhmm::parse_fasta_file(fasta_filename = fasta_filename)
  seqs <- t$sequence
  names(seqs) <- t$name
  seqs
}
