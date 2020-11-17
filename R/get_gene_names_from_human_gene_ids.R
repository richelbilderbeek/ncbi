#' From a human gene ID, get the gene name.
#' This function checks if the gene is indeed fror a human
#' @export
get_gene_names_from_human_gene_ids <- function(gene_ids) { # nolint keep long descriptive function name
  membrane_proteins_info <- rentrez::entrez_summary(
    db = "gene",
    id = gene_ids,
    rettype = "xml"
  )
  Sys.sleep(1)
  is_human <- purrr::flatten_lgl(
    purrr::map(membrane_proteins_info, function(e) e$organism$taxid == 9606)
  )
  testthat::expect_true(all(is_human))
  gene_names <- purrr::flatten_chr(
    purrr::map(membrane_proteins_info, function(e) e$name)
  )
  gene_names
}
