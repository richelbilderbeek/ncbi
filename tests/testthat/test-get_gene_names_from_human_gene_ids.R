test_that("multiplication works", {
  gene_ids <- c("1956", "7124", "348", "7040", "3091", "3586")
  gene_names <- get_gene_names_from_human_gene_ids(gene_ids)
  expected_gene_names <- c("EGFR", "TNF", "APOE", "TGFB1", "HIF1A", "IL10")
  expect_equal(gene_names, expected_gene_names)
})
