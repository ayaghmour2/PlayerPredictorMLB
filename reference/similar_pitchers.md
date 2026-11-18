# Find Similar Pitcher Seasons

Finds the pitcher seasons most similar to a user-supplied statistical
profile. Comparisons are restricted to pitcher seasons matching the
selected starter and reliever classifications. Starter and reliever
classifications manually imputed based on innings pitched, ratio of
starts to relief outings, numerical gap in starts and games pitched, and
subject matter knowledge.

## Usage

``` r
similar_pitchers(
  lob_pct,
  gb_pct,
  hr_fb,
  k_pct,
  bb_pct,
  barrel_pct,
  hardhit_pct,
  is_starter,
  is_reliever,
  n = 5,
  data = Pitching
)
```

## Arguments

- lob_pct:

  Left-on-Base Percentage.

- gb_pct:

  Ground Ball Percentage.

- hr_fb:

  Home Run per Fly Ball Percentage.

- k_pct:

  Strikeout Percentage.

- bb_pct:

  Walk Percentage.

- barrel_pct:

  Barrel Percentage.

- hardhit_pct:

  Hard-Hit Percentage.

- is_starter:

  Starter Indicator: either 0 or 1.

- is_reliever:

  Reliever Indicator: either 0 or 1.

- n:

  Number of similar player-seasons to return. Default is 5.

- data:

  Pitching data frame. Default is `Pitching`.

## Value

A data frame containing the most similar pitcher seasons.

## Examples

``` r
## Traditional Starter Example
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

## Traditional Reliever Example
reliever_results <- similar_pitchers(
  lob_pct = 77,
  gb_pct = 52,
  hr_fb = 13,
  k_pct = 38,
  bb_pct = 9,
  barrel_pct = 6,
  hardhit_pct = 42,
  is_starter = 0,
  is_reliever = 1,
  n = 10
)

## Swingman Example
swingman_results <- similar_pitchers(
  lob_pct = 72,
  gb_pct = 35,
  hr_fb = 7,
  k_pct = 20,
  bb_pct = 3,
  barrel_pct = 5,
  hardhit_pct = 30,
  is_starter = 1,
  is_reliever = 1,
  n = 10
)
```
