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
    "Do no accept frame shifts"
  )
})
