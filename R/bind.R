#' @export
df_special <- function(...) {
  vctrs::new_data_frame(x = vctrs::df_list(...), class = "df_special")
}

#' @export
bind_rows.df_special = function(..., .id = NULL) {
  dots <- dplyr:::bind_rows_dots(...)
  out <- vctrs::vec_rbind(!!!dots)
  out <- unclass(out)
  df_special(!!!out)
}

#' @export
df_next_method <- function(...) {
  vctrs::new_data_frame(x = vctrs::df_list(...), class = "df_next_method")
}

#' @export
bind_rows.df_next_method = function(..., .id = NULL) {
  out <- NextMethod()
  out <- unclass(out)
  df_next_method(!!!out)
}

#' @export
df_no_id <- function(...) {
  vctrs::new_data_frame(x = vctrs::df_list(...), class = "df_no_id")
}

#' @export
bind_rows.df_no_id = function(...) {
  dplyr:::bind_rows_dots(...)
}

#' @export
df_extra <- function(...) {
  vctrs::new_data_frame(x = vctrs::df_list(...), class = "df_extra")
}

#' @export
bind_rows.df_extra = function(..., .copy = FALSE) {
  list(dots = dplyr:::bind_rows_dots(...), copy = .copy)
}
