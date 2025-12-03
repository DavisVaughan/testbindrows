
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Example

``` r
library(testbindrows)
library(dplyr, warn.conflicts = FALSE)
```

``` r
x <- df_special(x = 1, y = 2)
y <- data.frame(x = 1, y = 2)

bind_rows(x, y)
#>   x y
#> 1 1 2
#> 2 1 2

# it is the right class
class(bind_rows(x, y))
#> [1] "df_special" "data.frame"

# reverse order calls normal data frame method
class(bind_rows(y, x))
#> [1] "data.frame"
```

``` r
x <- df_next_method(x = 1, y = 2)
y <- data.frame(x = 1, y = 2)

bind_rows(x, y)
#>   x y
#> 1 1 2
#> 2 1 2

# it is the right class
class(bind_rows(x, y))
#> [1] "df_next_method" "data.frame"

# reverse order calls normal data frame method
class(bind_rows(y, x))
#> [1] "data.frame"
```

This class doesn’t have the `.id` argument used in the data frame method
of `bind_rows()`. That’s totally fine with R CMD check since the generic
for `bind_rows()` is just `...`.

Since `bind_rows_dots()` removes the unmatched `.id` argument from the
equation, users can technically call `bind_rows()` with `.id` and it
will just get silently ignored.

This generally bodes well for us, as it means we can add extra optional
arguments to the data frame method of `bind_rows()` in the future, and
it won’t immediately break anything. In the worst case it will just
result in silent no-op behavior.

``` r
x <- df_no_id(x = 1, y = 2)
y <- data.frame(x = 1, y = 2)

bind_rows(x, y)
#> [[1]]
#>   x y
#> 1 1 2
#> 
#> [[2]]
#>   x y
#> 1 1 2

# ignored
bind_rows(x, y, .id = "foo")
#> [[1]]
#>   x y
#> 1 1 2
#> 
#> [[2]]
#>   x y
#> 1 1 2

# used because we go through the data frame method
bind_rows(y, x, .id = "foo")
#>   foo x y
#> 1   1 1 2
#> 2   2 1 2
```

This class has an *extra* argument, `.copy`, that isn’t present in the
generic or the data.frame method. That’s also fine. Again,
`bind_rows_dots()` ignores it for the purpose of dispatch, and if we hit
the data frame method then `bind_rows_dots()` there will ignore it again
because the data frame method doesn’t know about that argument.

``` r
x <- df_extra(x = 1, y = 2)
y <- data.frame(x = 1, y = 2)

bind_rows(x, y)
#> $dots
#> $dots[[1]]
#>   x y
#> 1 1 2
#> 
#> $dots[[2]]
#>   x y
#> 1 1 2
#> 
#> 
#> $copy
#> [1] FALSE

# used in the df_extra method
bind_rows(x, y, .copy = TRUE)
#> $dots
#> $dots[[1]]
#>   x y
#> 1 1 2
#> 
#> $dots[[2]]
#>   x y
#> 1 1 2
#> 
#> 
#> $copy
#> [1] TRUE

# ignored
bind_rows(y, x, .copy = TRUE)
#>   x y
#> 1 1 2
#> 2 1 2
```
