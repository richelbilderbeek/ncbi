#' Parse a HGVS variation description
#' @param s string in HVGS format to be parsed
#' @note see \url{http://varnomen.hgvs.org/} for the HGVS format
#' @return the variation as a list
#' @export
parse_hgvs <- function(s) {
  testthat::expect_true(length(s) == 1)
  frame_shift_match <- stringr::str_subset(
    s, "^.*:p.[A-Z][a-z]{1,2}[[:digit:]]+fs$"
  )
  if (length(frame_shift_match) != 0) {
    stop("Do no accept frame shifts, in sequence '", s, "'")
  }
  extensions_shift_match <- stringr::str_subset(
    s, "^.*:p\\..*ext.*$"
  )
  if (length(extensions_shift_match) != 0) {
    stop("Do no accept extensions, in sequence '", s, "'")
  }
  delins_match <- stringr::str_subset(
    s, "^.*:p\\..*delins.*$"
  )
  if (length(delins_match) != 0) {
    stop("Do no accept delins, in sequence '", s, "'")
  }

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
