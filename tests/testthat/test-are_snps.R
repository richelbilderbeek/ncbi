test_that("use", {
  expect_equal(
    are_snps(
      c(
        "NP_001771.1:p.Ser91Pro", # yes
        "NP_001771.1:p.Leu64_Gly74del", # no
        "NP_001254627.1:p.Val237Met", # yes
        "NP_001771.1:p.Phe89=", # no
        "NP_055635.3:p.Ala55Gly", # yes
        "NP_001771.1:p.Asp167fs" # no
      )
    ),
    c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
  )
})
