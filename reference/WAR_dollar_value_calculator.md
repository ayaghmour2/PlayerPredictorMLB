# Calculate WAR Dollar Value

Estimates a player's annual dollar value based on average WAR per season
using a piecewise valuation model.

## Usage

``` r
WAR_dollar_value_calculator(war, seasons)
```

## Arguments

- war:

  Total WAR accumulated in a specific time frame.

- seasons:

  Total seasons for the WAR.

## Value

Estimated annual dollar value in U.S. dollars. This value is numeric
stored invisibly, while a formatted dollar amount is displayed.

## Details

The first WAR is valued at \$7 million, the second WAR is valued at
\$8.5 million, and all WAR above 2.0 is valued at \$13 million.

This formula comes from a FanGraphs article published in July 2026. The
value is how much money the player would theoretically make on the open
market. The formula is tailored specifically for fWAR, but it will
produce useful predictions for bWAR as well.

## Examples

``` r
WAR_dollar_value_calculator(war = 7, seasons = 3)
#> Estimated Annual Value: $19,833,333 
WAR_dollar_value_calculator(war = 3.7, seasons = 1)
#> Estimated Annual Value: $37,600,000 
WAR_dollar_value_calculator(war = 0.7, seasons = 1)
#> Estimated Annual Value: $4,900,000 
```
