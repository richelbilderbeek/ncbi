test_that("use", {
  gene_ids <- c("1956", "7124", "348", "7040", "3091", "3586")
  gene_names <- get_gene_names_from_human_gene_ids(gene_ids)
  expected_gene_names <- c("EGFR", "TNF", "APOE", "TGFB1", "HIF1A", "IL10")
  expect_equal(gene_names, expected_gene_names)
})

test_that("verbose", {
  if (!pureseqtmr::is_on_travis()) return()
  expect_silent(
    get_gene_names_from_human_gene_ids(
      gene_ids = c("1956", "7124"),
      verbose = TRUE
    )
  )
})

test_that("use too many", {
  skip("WIP")
  gene_ids <- readr::read_csv(
    file = system.file("extdata", "all_gene_ids.csv", package = "ncbi"),
    col_types = readr::cols(gene_id = readr::col_double())
  )$gene_id
  gene_names <- get_gene_names_from_human_gene_ids(gene_ids)
  expected_gene_names <- c("EGFR", "TNF", "APOE", "TGFB1", "HIF1A", "IL10")
  expect_equal(gene_names, expected_gene_names)
})
