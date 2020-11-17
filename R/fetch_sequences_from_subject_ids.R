#' Fetch the sequence from a protein ID
#'
#' Fetch the protein sequence using a protein ID
#' @return text that can be saved as a FASTA file
#' @export
fetch_sequences_from_subject_ids <- function(subject_ids) { # nolint keep long descriptive function name
  fasta_raw <- rentrez::entrez_fetch(
    id = subject_ids,
    db = "protein",
    rettype = "fasta"
  )
  fasta_text <- stringr::str_split(fasta_raw, pattern = "\n")[[1]]
  fasta_text <- fasta_text[fasta_text != ""]
  fasta_text
}
