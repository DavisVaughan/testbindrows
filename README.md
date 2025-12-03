
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

This class doesn’t have the `.id` argument required by the `bind_rows()`
generic.

That seems to be okay with R CMD check, so that’s good.

But it seems like that means that the default value of `.id` will appear
as part of `...` in the S3 method that is missing the `.id` argument.

So that’s not great, it means we are going to have trouble extending
`bind_rows()` with new optional arguments in the future, because we
can’t add them *only* to the S3 method for data.frame, we have to add
them to the S3 generic as well. But if we add them to the S3 generic, it
breaks any packages out there that don’t have that argument in the
signature yet.

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
#> 
#> $.id
#> NULL
```
