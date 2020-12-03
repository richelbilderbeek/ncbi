#' From a human gene ID, get the gene name.
#' This function checks if the gene is indeed fror a human
#' @inheritParams default_params_doc
#' @export
get_gene_names_from_human_gene_ids <- function(# nolint keep long descriptive function name
  gene_ids,
  verbose = FALSE
) {
  # Must have at least 2 gene_ids for purrr to work
  testthat::expect_true(length(gene_ids) > 1)
  membrane_proteins_info <- rentrez::entrez_summary(
    db = "gene",
    id = gene_ids,
    rettype = "xml",
    config = httr::config(verbose = verbose)
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
