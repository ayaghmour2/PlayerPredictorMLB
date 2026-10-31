
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PlayerPredictorMLB

<!-- badges: start -->

<!-- badges: end -->

The goal of PlayerPredictorMLB is to explore MLB statistics from recent
seasons and use them to help predict future outcomes and value. The
package focuses on expected stats, including functions that can help you
predict a player’s xBA, xSLG, xwOBA, xERA, and xFIP, find similar
players, and calculate the monetary value of production based on a
player’s WAR.

## Installation

You can install the development version of PlayerPredictorMLB from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ayaghmour2/PlayerPredictorMLB")
```

## Data

The data used for this package comes from <https://www.fangraphs.com/>.
It covers batting and pitching statistics from the 2021 to 2026 MLB
season. Each function gives a quick definition of the variables used,
but for a more detailed definition, you can visity the glossary at
<https://library.fangraphs.com/>. The default datasets are built into
the functions, but users can use their own data instead, assuming they
have all necessary variables. The prediction functions are built on data
from 2021 to 2026, so it may not be useful using data from previous
seasons, especially the shortened 2020 season.

## Example

This is a basic example which shows you how to find similar batters:

``` r
batting_results <- similar_batters(
 bb_pct = 11,
 k_pct = 27,
 hr_fb = 24,
 barrel_pct = 14,
 hardhit_pct = 50,
 xba = 0.265,
 xslg = 0.500,
 xwoba = 0.378,
 n = 10
)
batting_results
#>                   Name Season Age  PA   AVG   OBP   SLG  wOBA HR   R RBI
#> 1  Pete Crow-Armstrong   2026  24 726 0.280 0.372 0.570 0.400 45 119 107
#> 2             Ben Rice   2026  27 667 0.264 0.363 0.534 0.384 41 105  97
#> 3      Elly De La Cruz   2026  24 636 0.283 0.365 0.515 0.380 30  99  79
#> 4          Jorge Soler   2023  31 580 0.250 0.341 0.512 0.361 36  77  75
#> 5        Rafael Devers   2024  27 601 0.272 0.354 0.516 0.364 28  87  83
#> 6         Joc Pederson   2024  32 449 0.275 0.393 0.515 0.391 23  62  64
#> 7    Giancarlo Stanton   2021  31 579 0.273 0.354 0.516 0.370 35  64  97
#> 8    Willson Contreras   2026  34 535 0.275 0.386 0.516 0.391 27  68  81
#> 9        Adolis García   2023  30 632 0.245 0.328 0.508 0.354 39 108 107
#> 10        Brent Rooker   2024  29 614 0.293 0.365 0.562 0.392 39  82 112
#>        wRC+
#> 1  156.5301
#> 2  148.7149
#> 3  139.2384
#> 4  125.7249
#> 5  137.2936
#> 6  152.3310
#> 7  138.1503
#> 8  150.7725
#> 9  127.8636
#> 10 163.6314
```

This is a basic example which shows you how to find similar pitchers,
specifically a traditional starting pitcher:

``` r
starter_results <- similar_pitchers(
 lob_pct = 81,
 gb_pct = 43,
 hr_fb = 9,
 k_pct = 30,
 bb_pct = 6,
 barrel_pct = 7,
 hardhit_pct = 38,
 is_starter = 1,
 is_reliever = 0,
 n = 10
)
starter_results
#>                Name Season Age    IP  W  L SV  ERA WHIP  SO BB
#> 1    Cam Schlittler   2026  25 193.2 14  6  0 1.95 0.92 239 49
#> 2       Gerrit Cole   2023  32 209.0 15  4  0 2.63 0.98 222 48
#> 3    Walker Buehler   2021  26 207.2 16  4  0 2.47 0.97 212 52
#> 4        Chris Sale   2025  36 125.2  7  5  0 2.58 1.07 165 32
#> 5     Kevin Gausman   2021  30 192.0 14  6  0 2.81 1.04 227 50
#> 6        Zac Gallen   2022  26 184.0 12  4  0 2.54 0.91 192 47
#> 7  Brandon Woodruff   2022  29 153.1 13  4  0 3.05 1.07 190 42
#> 8       Paul Skenes   2025  23 187.2 10 10  0 1.97 0.95 216 42
#> 9        Chris Sale   2026  37 162.2 14  9  0 2.16 0.98 200 31
#> 10     Tarik Skubal   2024  27 192.0 18  4  0 2.39 0.92 228 35
```

This is a basic example which would predict a player’s wOBA:

``` r
example_woba <-predict_woba(
 age = 27,
 xba = 0.280,
 xslg = 0.400,
 xwoba = 0.331,
 bb_pct = 9.2,
 k_pct = 13.3,
 iso = 0.096,
 wrc_plus = 95,
 hr_fb = 5.7,
 barrel_pct = 6.9,
 hardhit_pct = 44.3
)
example_woba
#> [1] 0.325
```

This is a basic example which would calculate a player’s value based on
WAR:

``` r
dollar_value <- WAR_dollar_value_calculator(war = 7, seasons = 3)
#> Estimated Annual Value: $19,833,333
dollar_value
#> [1] 19833333
```
