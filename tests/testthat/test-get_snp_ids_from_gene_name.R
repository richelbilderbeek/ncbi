test_that("use", {
  snp_ids <- get_snp_ids_from_gene_name(gene_name = "TNF")
  expect_equal(length(snp_ids), 1254)
  expect_snp_ids <- c(
    "1583051968",
    "1583051630",
    "1583051499",
    "1583051331",
    "1583051188",
    "1583051165"
  )
  expect_equal(head(snp_ids), expect_snp_ids)
})

test_that("gene that has even more SNPs", {
  snp_ids <- get_snp_ids_from_gene_name(gene_name = "EGFR")
  expect_equal(length(snp_ids), 48836)
})

