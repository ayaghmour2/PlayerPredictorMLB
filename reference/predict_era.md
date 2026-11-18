# Predict Earned Run Average

Predicts a pitcher's earned run average based on statistics from a
specific season.

## Usage

``` r
predict_era(
  age,
  babip,
  hr_fb,
  xera,
  xfip,
  ip,
  lob_pct,
  k_pct,
  bb_pct,
  barrel_pct,
  hardhit_pct,
  is_starter,
  is_reliever,
  data = Pitching
)
```

## Arguments

- age:

  Pitcher age during the specific season.

- babip:

  Batting average on balls in play.

- hr_fb:

  Home-run-to-fly-ball rate.

- xera:

  Expected earned run average.

- xfip:

  Expected fielding independent pitching.

- ip:

  Innings pitched.

- lob_pct:

  Left-on-base percentage.

- k_pct:

  Strikeout percentage.

- bb_pct:

  Walk percentage.

- barrel_pct:

  Barrel percentage.

- hardhit_pct:

  Hard-hit percentage.

- is_starter:

  Numeric indicator equal to `1` if the pitcher can be classified as a
  starter and `0` otherwise.

- is_reliever:

  Numeric indicator equal to `1` if the pitcher can be classified as a
  reliever and `0` otherwise.

- data:

  Pitching dataset used to fit the projection model.

## Value

Predicted earned run average for the next season as a numeric value
rounded to two decimal places.

## Details

Predictors are standardized before the regression model is fitted. The
standardized coefficient for expected earned run average (`xERA`) is
constrained to be at least twice as large in absolute value as every
other predictor coefficient.

Percentage inputs may be supplied as either proportions or percentage
points. For example, a strikeout rate may be entered as either `0.225`
or `22.5` and produce the same result.

## Examples

``` r
starter_example <-predict_era(
  age = 25,
  babip = 0.251,
  hr_fb = 9.1,
  xera = 2.85,
  xfip = 2.86,
  ip = 193.2,
  lob_pct = 81.7,
  k_pct = 31.4,
  bb_pct = 6.4,
  barrel_pct = 7.3,
  hardhit_pct = 38.1,
  is_starter = 1,
  is_reliever = 0
)
starter_example
#> [1] 3.67

reliever_example <-predict_era(
  age = 26,
  babip = 0.279,
  hr_fb = 13,
  xera = 2.52,
  xfip = 2.36,
  ip = 68.2,
  lob_pct = 77,
  k_pct = 37.8,
  bb_pct = 9.8,
  barrel_pct = 6.2,
  hardhit_pct = 42.5,
  is_starter = 0,
  is_reliever = 1
)
reliever_example
#> [1] 2.88

swingman_example <-predict_era(
  age = 27,
  babip = 0.272,
  hr_fb = 15.2,
  xera = 3.55,
  xfip = 4.09,
  ip = 132.2,
  lob_pct = 73.3,
  k_pct = 28.7,
  bb_pct = 6.5,
  barrel_pct = 9.9,
  hardhit_pct = 36.9,
  is_starter = 1,
  is_reliever = 1
)
swingman_example
#> [1] 3.76
```
