#' Parse a HGVS variation description
#' @return the variation as a list
#' @export
parse_hgvs <- function(s) {
  m <- stringr::str_match(
    s, "^(.*):p.([A-Z][a-z]{1,2})([[:digit:]]+)(\\=|[A-Z][a-z]{1,2})$")
  variation <- list(
    name = m[1, 2],
    pos = as.numeric(m[1, 4]),
    from = m[1, 3],
    to = m[1, 5]
  )
  if (variation$to == "=") {
    variation$to <- variation$from
  }
  variation
}

