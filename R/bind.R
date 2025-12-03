#' @export
df_special <- function(...) {
  vctrs::new_data_frame(x = vctrs::df_list(...), class = "df_special")
}

#' @export
bind_rows.df_special = function(..., .id = NULL) {
  dots <- rlang::list2(...)
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
  rlang::list2(...)
}
