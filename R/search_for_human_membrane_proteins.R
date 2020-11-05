#' Get the IDs of human membrane proteins.
#' @seealso
#' Search terms are documented at
#' \url{https://www.ncbi.nlm.nih.gov/books/NBK25499/#_chapter4_ESearch_}.
#' The Protein Advanced Search Builder at
#' \url{https://www.ncbi.nlm.nih.gov/protein/advanced}
#' helps to generate a specific search term
#' @export
search_for_human_membrane_proteins <- function() {
  hits <- rentrez::entrez_search(
    db = "protein",
    term = "(membrane protein) AND Homo Sapiens[Organism]",
    rettype = "fasta"
  )
  hits$ids
}
