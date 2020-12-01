test_that("use", {
  gene_ids <- get_all_human_membrane_protein_gene_ids()
  expect_true(length(gene_ids) > 1125)
})
