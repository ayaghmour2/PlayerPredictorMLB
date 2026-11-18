# Find Similar Batter Seasons

Finds the batter seasons most similar to a user-supplied statistical
profile using standardized Euclidean distance.

## Usage

``` r
similar_batters(
  bb_pct,
  k_pct,
  hr_fb,
  barrel_pct,
  hardhit_pct,
  xba,
  xslg,
  xwoba,
  n = 5,
  data = Batting
)
```

## Arguments

- bb_pct:

  Walk Percentage.

- k_pct:

  Strikeout Percentage.

- hr_fb:

  Home Run per Fly Ball Percentage.

- barrel_pct:

  Barrel Percentage.

- hardhit_pct:

  Hard-Hit Percentage.

- xba:

  Expected Batting Average.

- xslg:

  Expected Slugging Percentage.

- xwoba:

  Expected Weighted On-Base Average.

- n:

  Number of Similar Player-Seasons to Return. Default is 5.

- data:

  Batting data frame. Default is `Batting`.

## Value

A data frame containing the most similar batter seasons.

## Examples

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
```
