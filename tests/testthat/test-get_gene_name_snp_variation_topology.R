test_that("use", {
  t <- get_gene_name_snp_variation_topology(gene_name = "TNF")
  expect_true("snp_id" %in% names(t))
  expect_true("variation" %in% names(t))
  expect_true("is_in_tmh" %in% names(t))
})
