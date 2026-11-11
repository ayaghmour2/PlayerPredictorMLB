## Test Helper Function
test_that(".calculate_similarity returns numeric distances", {

  test_data <- data.frame(
    AVG = c(0.223, 0.267, 0.280),
    OBP = c(0.234, 0.285, 0.320)
  )

  target <- c(
    "AVG" = 0.223,
    "OBP" = 0.285
  )

  result <- .calculate_similarity(
    data = test_data,
    target = target,
    stats = c("AVG", "OBP")
  )

  expect_type(result, "double")
  expect_length(result, 3)
})

## Distance Should Be Zero for Exact
test_that("exact matching row has distance 0", {

  test_data <- data.frame(
    AVG = c(0.223, 0.267, 0.280),
    OBP = c(0.234, 0.285, 0.320)
  )

  target <- c(
    "AVG" = 0.267,
    "OBP" = 0.285
  )

  result <- .calculate_similarity(
    test_data,
    target,
    c("AVG", "OBP")
  )

  expect_equal(result[2], 0)
})

## Non-Numeric Values Cause Errors
test_that("non-numeric comparison columns produce error", {

  test_data <- data.frame(
    AVG = c(0.223, 0.267, 0.280),
    OBP = c(0.234, "Right", "Left")
  )

  target <- c(
    "AVG" = 0.267,
    "OBP" = 0.285
  )

  expect_error(
    .calculate_similarity(
      test_data,
      target,
      c("AVG", "OBP")
    ),
  "must be numeric"
  )
})

## Percentage Conversion Test
test_that("percentage inputs are converted from percent to decimal", {

  test_data <- data.frame(
    `BB%` = c(0.8, 0.10, 0.12),
    `K%` = c(0.24, 0.27, 0.33),
    check.names = FALSE
  )

  result1 <- .calculate_similarity(
    test_data,
    target = c(
      "BB%" = 8,
      "K%" = 24
    ),
    stats = c("BB%", "K%")
  )

  result2 <- .calculate_similarity(
    test_data,
    target = c(
      "BB%" = 0.08,
      "K%" = 0.24
    ),
    stats = c("BB%", "K%")
  )

  expect_equal(result1, result2)
})

## N Must Be Positive
test_that("n must be positive", {

  expect_error(
    similar_batters(
      bb_pct = 10.4,
      k_pct = 25.3,
      hr_fb = 15,
      barrel_pct = 8.7,
      hardhit_pct = 45.6,
      xba = .247,
      xslg = .430,
      xwoba = .360,
      n = -3,
      data = Batting
    ),
    "positive number"
  )
})

## Return Exactly N Player-Seasons
test_that("number of rows returned does not exceed n", {

  result <- similar_batters(
    bb_pct = 8.5,
    k_pct = 23.4,
    hr_fb = 19.1,
    barrel_pct = 8.5,
    hardhit_pct = 34.5,
    xba = .290,
    xslg = .390,
    xwoba = .335,
    n = 5
  )

  expect_lte(nrow(result), 5)
})

## Invalid Role Combination
test_that("one role indicator must equal 1", {

  expect_error(
    similar_pitchers(
      lob_pct = 65.8,
      gb_pct = 45.7,
      hr_fb = 12.3,
      k_pct = 27.6,
      bb_pct = 9.5,
      barrel_pct = 8.3,
      hardhit_pct = 42.5,
      is_starter = 0,
      is_reliever = 0
    ),
    "At least one"
  )
})

## Role Must Be Binary
test_that("role indicators must be binary", {

  expect_error(
    similar_pitchers(
      lob_pct = 65.8,
      gb_pct = 45.7,
      hr_fb = 12.3,
      k_pct = 27.6,
      bb_pct = 9.5,
      barrel_pct = 8.3,
      hardhit_pct = 42.5,
      is_starter = 2,
      is_reliever = 0
    ),
    "either 0 or 1"
  )
})

## Ensure Dataframe
test_that("similar_batters returns a standard data frame", {

  result <- similar_batters(
    bb_pct = 9,
    k_pct = 22.1,
    hr_fb = 18.9,
    barrel_pct = 11.9,
    hardhit_pct = 41.6,
    xba = .256,
    xslg = .466,
    xwoba = .343
  )

  expect_s3_class(result, "data.frame")

  expect_false(tibble::is_tibble(result))

  expect_false(
    inherits(result, c("tbl_df", "tbl"))
  )

  expect_true(is.data.frame(result))
})

## Expect Accurately Rounded Batting Stats
test_that("batting rate stats are formatted to three decimals", {

  result <- similar_batters(
    bb_pct = 9,
    k_pct = 22.1,
    hr_fb = 18.9,
    barrel_pct = 11.9,
    hardhit_pct = 41.6,
    xba = .256,
    xslg = .466,
    xwoba = .343
  )

  rate_cols <- c(
    "AVG",
    "OBP",
    "SLG",
    "wOBA"
  )

  for (col in rate_cols) {

    expect_true(
      all(
        grepl(
          "^0\\.[0-9]{3}$",
          result[[col]]
        )
      ),
      info = paste("Failed for", col)
    )

  }
})

## Expect Accurately Rounded Pitching Stats
test_that("pitching rate stats are formatted to three decimals", {

  result <- similar_pitchers(
    lob_pct = 81.4,
    gb_pct = 44.3,
    hr_fb = 9.3,
    k_pct = 25.8,
    bb_pct = 6.6,
    barrel_pct = 5,
    hardhit_pct = 34.3,
    is_starter = 1,
    is_reliever = 0
  )

  expect_true(
    all(result$ERA == round(result$ERA, 2))
  )

  expect_true(
    all(result$WHIP == round(result$WHIP, 2))
  )
})

##     ##
## End ##
##     ##
