#' Parse a HGVS variation description
#' @param s string in HVGS format to be parsed
#' @return the variation as a list
#' @export
parse_hgvs <- function(s) {
  frame_shift_match <- stringr::str_subset(
    s, "^.*:p.[A-Z][a-z]{1,2}[[:digit:]]+fs$"
  )
  if (length(frame_shift_match) != 0) {
    stop("Do no accept frame shifts, in sequence '", s, "'")
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
