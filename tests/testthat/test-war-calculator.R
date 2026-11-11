## WAR Must Be Numeric
test_that("WAR must be numeric", {

  expect_error(
    WAR_dollar_value_calculator(
      war = "five",
      seasons = 2
    ),
    "WAR must be a single number"
  )

})

## Seasons Must Be Numeric
test_that("seasons must be numeric", {

  expect_error(
    WAR_dollar_value_calculator(
      war = 5,
      seasons = "two"
    ),
    "Seasons must be a single number"
  )

})

## Seasons > 0
test_that("seasons must be greater than zero", {

  expect_error(
    WAR_dollar_value_calculator(
      war = 5,
      seasons = 0
    ),
    "greater than 0"
  )

})

## WAR Between 0 and 1 is Worth $7 Million per WAR
test_that("WAR below one is valued at 7 million per WAR", {

  result <- WAR_dollar_value_calculator(
    war = 0.5,
    seasons = 1
  )

  expect_equal(
    result,
    3500000
  )

})

## 1 WAR is Worth $7 Million
test_that("WAR below one is valued at 7 million per WAR", {

  result <- WAR_dollar_value_calculator(
    war = 1,
    seasons = 1
  )

  expect_equal(
    result,
    7000000
  )

})

## WAR Between 1 and 2 is Worth $8.5 Million per WAR
test_that("second WAR tier is valued correctly", {

  result <- WAR_dollar_value_calculator(
    war = 1.5,
    seasons = 1
  )

  expect_equal(
    result,
    11250000
  )

})

## 2 WAR is Worth $15.5 Million
test_that("two WAR is valued correctly", {

  result <- WAR_dollar_value_calculator(
    war = 2,
    seasons = 1
  )

  expect_equal(
    result,
    15500000
  )

})

## Any WAR Above 2 is Valued at $13 Million per WAR
test_that("WAR above two uses third valuation tier", {

  result <- WAR_dollar_value_calculator(
    war = 2.5,
    seasons = 1
  )

  expect_equal(
    result,
  22000000
  )

})

## WAR is Averaged Across Seasons
test_that("WAR is averaged across seasons", {

  result <- WAR_dollar_value_calculator(
    war = 6,
    seasons = 3
  )

  expect_equal(
    result,
    15500000
  )

})

## Negative WAR Returns Negative Value
test_that("negative WAR returns negative value", {

  result <- WAR_dollar_value_calculator(
    war = -0.5,
    seasons = 1
  )

  expect_equal(
    result,
    -3500000
  )

})

##     ##
## End ##
##     ##
