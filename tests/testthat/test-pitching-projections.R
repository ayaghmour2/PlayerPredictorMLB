## Test that Consecutive Seasons Match
test_that("consecutive seasons are matched correctly", {

  mock_data <- data.frame(
    PlayerId = c(1, 1),
    Season = c(2023, 2024),

    Age = c(25, 26),
    BABIP = c(.290, .300),
    `HR/FB` = c(.10, .11),
    xERA = c(3.4, 3.5),
    xFIP = c(3.6, 3.7),
    IP = c(180, 185),
    `LOB%` = c(.75, .76),
    `K%` = c(.25, .26),
    `BB%` = c(.08, .09),
    `Barrel%` = c(.08, .08),
    `HardHit%` = c(.40, .41),
    `Is Starter` = c(1, 1),
    `Is Reliever` = c(0, 0),

    ERA = c(4.2, 3.7),

    check.names = FALSE
  )

  result <- .create_pitching_training_data(
    mock_data,
    "ERA"
  )

  expect_equal(nrow(result), 1)

})

## Test Invalid Pitching Classifications
test_that("invalid pitcher classifications are removed", {

  mock_data <- Pitching

  mock_data$`Is Starter` <- 7

  expect_error(
    .create_pitching_training_data(
      mock_data,
      "ERA"
    ),
    "valid pitcher classifications"
  )

})

## Test that Primary Stat Exists
test_that("primary stat must exist", {

  expect_error(
    .fit_pitching_projection(
      data = Pitching,
      outcome = "ERA",
      primary_stat = "XYZ"
    ),
    "primary_stat"
  )

})

## Test that Model Returns Expected Components
test_that("pitching projection model returns expected components", {

  model <- .fit_pitching_projection(
    Pitching,
    outcome = "ERA",
    primary_stat = "xERA"
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

## Test All Values are Numeric
test_that("all inputs must be numeric", {

  expect_error(
    .predict_pitching_stat(
      age = "25",
      babip = .300,
      hr_fb = 10,
      xera = 3.5,
      xfip = 3.4,
      ip = 180,
      lob_pct = 75,
      k_pct = 25,
      bb_pct = 8,
      barrel_pct = 8,
      hardhit_pct = 40,
      is_starter = 1,
      is_reliever = 0,
      outcome = "ERA",
      primary_stat = "xERA",
      data = valid_pitching_data
    ),
    "single finite numeric values"
  )

})

## Ensure Starter is 0 or 1
test_that("starter indicator must be 0 or 1", {

  expect_error(
    .predict_pitching_stat(
      age = 25,
      babip = .300,
      hr_fb = 10,
      xera = 3.5,
      xfip = 3.4,
      ip = 180,
      lob_pct = 75,
      k_pct = 25,
      bb_pct = 8,
      barrel_pct = 8,
      hardhit_pct = 40,
      is_starter = 4,
      is_reliever = 0,
      outcome = "ERA",
      primary_stat = "xERA",
    ),
    "either 0 or 1"
  )

})

## Ensure Reliever is 0 or 1
test_that("reliever indicator must be 0 or 1", {

  expect_error(
    .predict_pitching_stat(
      age = 25,
      babip = .300,
      hr_fb = 10,
      xera = 3.5,
      xfip = 3.4,
      ip = 180,
      lob_pct = 75,
      k_pct = 25,
      bb_pct = 8,
      barrel_pct = 8,
      hardhit_pct = 40,
      is_starter = 0,
      is_reliever = 5,
      outcome = "ERA",
      primary_stat = "xERA",
    ),
    "either 0 or 1"
  )

})

## Test that One Role is Required
test_that("one pitcher classification must equal 1", {

  expect_error(
    .predict_pitching_stat(
      age = 25,
      babip = .300,
      hr_fb = 10,
      xera = 3.5,
      xfip = 3.4,
      ip = 180,
      lob_pct = 75,
      k_pct = 25,
      bb_pct = 8,
      barrel_pct = 8,
      hardhit_pct = 40,
      is_starter = 0,
      is_reliever = 0,
      outcome = "ERA",
      primary_stat = "xERA",
    ),
    "At least one pitcher classification"
  )

})

## Ensure Results are Numeric
test_that("prediction is numeric", {

  result <- .predict_pitching_stat(
    age = 25,
    babip = .300,
    hr_fb = 10,
    xera = 3.5,
    xfip = 3.7,
    ip = 180,
    lob_pct = 75,
    k_pct = 25,
    bb_pct = 8,
    barrel_pct = 8,
    hardhit_pct = 40,
    is_starter = 1,
    is_reliever = 0,
    outcome = "ERA",
    primary_stat = "xERA",
    data = Pitching
  )

  expect_type(result, "double")

})

## Ensure Results are To Two Decimals
test_that("prediction is rounded to two decimals", {

  result <- .predict_pitching_stat(
    age = 25,
    babip = .300,
    hr_fb = 10,
    xera = 3.5,
    xfip = 3.7,
    ip = 180,
    lob_pct = 75,
    k_pct = 25,
    bb_pct = 8,
    barrel_pct = 8,
    hardhit_pct = 40,
    is_starter = 1,
    is_reliever = 0,
    outcome = "ERA",
    primary_stat = "xERA",
    data = Pitching
  )

  expect_equal(
    result,
    round(result, 2)
  )

})

## Prediction Cannot be Negative
test_that("prediction cannot be negative", {

  result <- .predict_pitching_stat(
    age = 25,
    babip = .300,
    hr_fb = 10,
    xera = 3.5,
    xfip = 3.7,
    ip = 180,
    lob_pct = 75,
    k_pct = 25,
    bb_pct = 8,
    barrel_pct = 8,
    hardhit_pct = 40,
    is_starter = 1,
    is_reliever = 0,
    outcome = "ERA",
    primary_stat = "xERA",
    data = Pitching
  )

  expect_gte(result, 0)

})

## Predict ERA Returns Numeric
test_that("predict_era returns numeric value", {

  result <- predict_era(
    age = 25,
    babip = .300,
    hr_fb = 10,
    xera = 3.5,
    xfip = 3.7,
    ip = 180,
    lob_pct = 75,
    k_pct = 25,
    bb_pct = 8,
    barrel_pct = 8,
    hardhit_pct = 40,
    is_starter = 1,
    is_reliever = 0,
  )

  expect_type(result, "double")

})

## Predict FIP Returns Negative
test_that("predict_fip returns numeric value", {

  result <- predict_fip(
    age = 25,
    babip = .300,
    hr_fb = 10,
    xera = 3.5,
    xfip = 3.7,
    ip = 180,
    lob_pct = 75,
    k_pct = 25,
    bb_pct = 8,
    barrel_pct = 8,
    hardhit_pct = 40,
    is_starter = 1,
    is_reliever = 0,
  )

  expect_type(result, "double")

})

##     ##
## End ##
##     ##
