
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
