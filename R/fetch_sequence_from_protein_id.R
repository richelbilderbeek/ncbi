#' Fetch the sequence from a protein ID
#'
#' Fetch the protein sequence using a protein ID
#' @inheritParams default_params_doc
#' @export
fetch_sequence_from_protein_id <- function(
  protein_id,
  verbose = FALSE
) {
  fasta_raw <- NA
  tryCatch({
    fasta_raw <- rentrez::entrez_fetch(
      id = protein_id,
      db = "protein",
      rettype = "fasta",
      config = httr::config(verbose = verbose)
    )
    }, error = function(e) {
      stop(
        "Error for protein ID '", protein_id, "': ", e
      )
    }
  )
  fasta_text <- stringr::str_split(fasta_raw, pattern = "\n")[[1]]
  seq <- paste0(fasta_text[-1], collapse = "")
  names(seq) <- stringr::str_sub(fasta_text[1], 2)
  seq
}
