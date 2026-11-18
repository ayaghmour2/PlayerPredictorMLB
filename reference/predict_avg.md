# Predict Batting Average

Predicts a player's batting average based on statistics from their most
recent season.

## Usage

``` r
predict_avg(
  age,
  xba,
  xslg,
  xwoba,
  bb_pct,
  k_pct,
  iso,
  wrc_plus,
  hr_fb,
  barrel_pct,
  hardhit_pct,
  data = Batting
)
```

## Arguments

- age:

  Player age during their most recent season.

- xba:

  Expected batting average from the most recent season.

- xslg:

  Expected slugging percentage from the most recent season.

- xwoba:

  Expected weighted on-base average from the most recent season.

- bb_pct:

  Walk percentage from the most recent season.

- k_pct:

  Strikeout percentage from the most recent season.

- iso:

  Isolated power from the most recent season.

- wrc_plus:

  Weighted runs from the most recent season.

- hr_fb:

  Home-run-to-fly-ball rate from the most recent season.

- barrel_pct:

  Barrel percentage from the most recent season.

- hardhit_pct:

  Hard-hit percentage from the most recent season.

- data:

  Batting dataset used to fit the projection model.

## Value

Predicted batting average for the following season as a numeric value
rounded to three decimal places.

## Details

Predictors are standardized before the regression model is fitted. The
standardized coefficient for expected batting average (`xBA`) is
constrained to be at least twice as large in absolute value as the
next-largest predictor coefficient.

## Examples

``` r
predict_avg(
  age = 27,
  xba = 0.261,
  xslg = 0.358,
  xwoba = 0.319,
  bb_pct = 9.7,
  k_pct = 16.1,
  iso = 0.125,
  wrc_plus = 111,
  hr_fb = 11.1,
  barrel_pct = 3.7,
  hardhit_pct = 27.1
)
#> [1] 0.259
```
