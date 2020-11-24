test_that("use", {
  if (!cobaltr::is_cobalt_installed()) return()
  fasta_text <- c(
    ">A",
    "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD",
    ">B",
    "IGSFQFGYNTGVINAPEKIIKEFITKTLT"
  )
  aligned_fasta_text <- create_msa(fasta_text)
  expect_equal(
    aligned_fasta_text,
    c(
      ">A",
      "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD",
      ">B",
      "-IGSFQFGYNTGVINAPEKIIKEFITKTLT-"
    )
  )
})
