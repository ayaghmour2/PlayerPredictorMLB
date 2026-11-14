## Test that Consecutive Seasons Match
test_that("consecutive seasons are matched correctly", {

  mock_data <- data.frame(
    PlayerId = c(1, 1),
    Season = c(2023, 2024),

    Age = c(25, 26),
    xBA = c(0.250, 0.270),
    xSLG = c(0.420, 0.450),
    xwOBA = c(0.320, 0.340),
    `BB%` = c(0.08, 0.09),
    `K%` = c(0.22, 0.20),
    ISO = c(0.170, 0.190),
    `wRC+` = c(105, 115),
    `HR/FB` = c(0.12, 0.14),
    `Barrel%` = c(0.07, 0.09),
    `HardHit%` = c(0.38, 0.42),

    AVG = c(0.250, 0.280),

    check.names = FALSE
  )

  result <- .create_batting_training_data(
    mock_data,
    "AVG"
  )

  expect_equal(nrow(result), 1)

})

## Test that Primary Stat Exists
test_that("primary statistic must exist", {

  expect_error(
    .fit_batting_projection(
      data = Batting,
      outcome = "AVG",
      primary_stat = "XYZ"
    ),
    "primary_stat"
  )

})

## Model Contains Expected Outcomes
test_that("model contains expected elements", {

  model <- .fit_batting_projection(
    data = Batting,
    outcome = "AVG",
    primary_stat = "xBA"
  )

  expect_named(
    model,
    c(
      "coefficients",
      "intercept",
      "means",
      "sds"
    )
  )

})

## All Inputs Must be Numeric
test_that("all inputs must be numeric", {

  expect_error(
    .predict_batting_stat(
      age = "26",
      xba = .250,
      xslg = .450,
      xwoba = .340,
      bb_pct = 10,
      k_pct = 20,
      iso = .200,
      wrc_plus = 120,
      hr_fb = 15,
      barrel_pct = 10,
      hardhit_pct = 40,
      outcome = "AVG",
      primary_stat = "xBA",
      data = Batting
    ),
    "finite numeric values"
  )

})

## Ensure Results are Numeric
test_that("prediction is numeric", {

    prediction <- .predict_batting_stat(
      age = 26,
      xba = .250,
      xslg = .450,
      xwoba = .340,
      bb_pct = 10,
      k_pct = 20,
      iso = .200,
      wrc_plus = 120,
      hr_fb = 15,
      barrel_pct = 10,
      hardhit_pct = 40,
      outcome = "AVG",
      primary_stat = "xBA",
      data = Batting
    )

  expect_type(prediction, "double")

})

## Test that Predictions are Rounded to Three Decimals
test_that("prediction is rounded to three decimals", {

  prediction <- .predict_batting_stat(
    age = 26,
    xba = .250,
    xslg = .450,
    xwoba = .340,
    bb_pct = 10,
    k_pct = 20,
    iso = .200,
    wrc_plus = 120,
    hr_fb = 15,
    barrel_pct = 10,
    hardhit_pct = 40,
    outcome = "AVG",
    primary_stat = "xBA",
    data = Batting
  )

  expect_equal(
    prediction,
    round(prediction, 3)
  )

})

## Predictions are Between 0 and 1
test_that("prediction is constrained between zero and one", {

  prediction <- .predict_batting_stat(
    age = 26,
    xba = .250,
    xslg = .450,
    xwoba = .340,
    bb_pct = 10,
    k_pct = 20,
    iso = .200,
    wrc_plus = 120,
    hr_fb = 15,
    barrel_pct = 10,
    hardhit_pct = 40,
    outcome = "AVG",
    primary_stat = "xBA",
    data = Batting
  )

  expect_gte(prediction, 0)

  expect_lte(prediction, 1)

})

## Test that 10% = 0.1
test_that("percentage inputs may be supplied as percentages", {

  result1 <- .predict_batting_stat(
    age = 26,
    xba = .250,
    xslg = .450,
    xwoba = .340,
    bb_pct = 10,
    k_pct = 20,
    iso = .200,
    wrc_plus = 120,
    hr_fb = 15,
    barrel_pct = 10,
    hardhit_pct = 40,
    outcome = "AVG",
    primary_stat = "xBA",
    data = Batting
  )

  result2 <- .predict_batting_stat(
    age = 26,
    xba = .250,
    xslg = .450,
    xwoba = .340,
    bb_pct = .1,
    k_pct = .2,
    iso = .200,
    wrc_plus = 120,
    hr_fb = .15,
    barrel_pct = .1,
    hardhit_pct = .4,
    outcome = "AVG",
    primary_stat = "xBA",
    data = Batting
  )

  expect_equal(
    result1,
    result2
  )

})

## Make Sure Average is Numeric
test_that("predict_avg returns numeric value", {

  result <- predict_avg(
    age = 26,
    xba = .250,
    xslg = .450,
    xwoba = .340,
    bb_pct = 10,
    k_pct = 20,
    iso = .200,
    wrc_plus = 120,
    hr_fb = 15,
    barrel_pct = 10,
    hardhit_pct = 40,
  )

  expect_type(result, "double")

})

## Make Sure Slugging is Numeric
test_that("predict_slg returns numeric value", {

  result <- predict_slg(
    age = 26,
    xba = .250,
    xslg = .450,
    xwoba = .340,
    bb_pct = 10,
    k_pct = 20,
    iso = .200,
    wrc_plus = 120,
    hr_fb = 15,
    barrel_pct = 10,
    hardhit_pct = 40,
  )

  expect_type(result, "double")

})

## Make Sure wOBA is Numeric
test_that("predict_woba returns numeric value", {

  result <- predict_slg(
    age = 26,
    xba = .250,
    xslg = .450,
    xwoba = .340,
    bb_pct = 10,
    k_pct = 20,
    iso = .200,
    wrc_plus = 120,
    hr_fb = 15,
    barrel_pct = 10,
    hardhit_pct = 40,
  )

  expect_type(result, "double")

})

##     ##
## End ##
##     ##
