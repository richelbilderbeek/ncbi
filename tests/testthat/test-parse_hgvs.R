test_that("use", {
  variation <- parse_hgvs(s = "NP_000585.2:p.Leu196=")
  expect_equal(variation$name, "NP_000585.2")
  expect_equal(variation$pos, 196)
  expect_equal(variation$from, "Leu")
  expect_equal(variation$to, "Leu")
})

test_that("use", {
  variation <- parse_hgvs(s = "NP_000585.2:p.Gly144Asp")
  expect_equal(variation$name, "NP_000585.2")
  expect_equal(variation$pos, 144)
  expect_equal(variation$from, "Gly")
  expect_equal(variation$to, "Asp")
})

test_that("use", {
  expect_error(
    parse_hgvs(s = "NP_000585.2:p.Pro84fs"),
    "Do not accept frame shifts"
  )

  expect_error(
    parse_hgvs(s = "NP_068743.3:p.Ter846TyrextTer?"),
    "Do not accept extensions"
  )

  expect_error(
    parse_hgvs(s = "NP_001172112.1:p.Arg249delinsThrGluArgTer"),
    "Do not accept delins"
  )

  expect_error(
    parse_hgvs(
      s = "NP_055640.2:p.Leu2235_Leu2236insArgLeuGlyAlaGlnArgProAspThr"
    ),
    "Do not accept insertions"
  )

  expect_error(
    parse_hgvs(s = "NP_001180552.1:p.Pro27del"),
    "Do not accept deletions"
  )

  expect_error(
    parse_hgvs(s = "NP_056980.2:p.Leu292dup"),
    "Do not accept duplications"
  )

})
