# Predict Slugging Percentage

Predicts a player's slugging percentage based on statistics from their
most recent season.

## Usage

``` r
predict_slg(
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

Predicted slugging percentage for the following season as a numeric
value rounded to three decimal places.

## Details

Predictors are standardized before the regression model is fitted. The
standardized coefficient for expected slugging percentage (`xSLG`) is
constrained to be at least twice as large in absolute value as the
next-largest predictor coefficient.

## Examples

``` r
predict_slg(
  age = 27,
  xba = 0.267,
  xslg = 0.511,
  xwoba = 0.378,
  bb_pct = 12.7,
  k_pct = 24.3,
  iso = 0.271,
  wrc_plus = 149,
  hr_fb = 24.4,
  barrel_pct = 14.3,
  hardhit_pct = 48.6
)
#> [1] 0.463
```
