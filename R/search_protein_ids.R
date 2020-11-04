#' Search for a protein its ID
#'
#' Search for the ID of a human protein.
#' @param accession protein accession (?), for example, \code{4ZW9}.
#' @seealso
#' Search terms are documented at
#' \url{https://www.ncbi.nlm.nih.gov/books/NBK25499/#_chapter4_ESearch_}.
#' The Protein Advanced Search Builder at
#' \url{https://www.ncbi.nlm.nih.gov/protein/advanced}
#' helps to generate a specific search term
#' @export
search_protein_ids <- function(accession) {
  term <- paste0("(", accession, "[Accession]) AND Homo Sapiens[Organism]")

  hits <- rentrez::entrez_search(
    db = "protein",
    term = term,
    rettype = "fasta"
  )
  hits
  hits$ids
}
