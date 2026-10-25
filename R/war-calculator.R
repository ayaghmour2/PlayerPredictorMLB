#' Calculate WAR Dollar Value
#'
#' Estimates a player's annual dollar value based on average WAR per
#' season using a piecewise valuation model.
#'
#' The first WAR is valued at $7 million, the second WAR is valued at
#' $8.5 million, and all WAR above 2.0 is valued at $13 million.
#'
#' This formula comes from a FanGraphs article published in July 2026. The value
#' is how much money the player would theoretically make on the open market.
#'
#' @param war Total WAR accumulated in a specific time frame.
#' @param seasons Total seasons for the WAR.
#'
#' @return Estimated annual dollar value in U.S. dollars. This value is numeric
#' stored invisibly, while a formatted dollar amount is displayed.
#'
#' @examples
#' WAR_dollar_value_calculator(war = 7, seasons = 3)
#' WAR_dollar_value_calculator(war = 3.7, seasons = 1)
#' WAR_dollar_value_calculator(war = 0.7, seasons = 1)
#'
#' @export
WAR_dollar_value_calculator <- function(war, seasons) {

  if (!is.numeric(war) || length(war) != 1 || is.na(war)) {
    stop("WAR must be a single number.")
  }

  if (!is.numeric(seasons) || length(seasons) != 1 || is.na(seasons)) {
    stop("Seasons must be a single number.")
  }

  if (seasons <= 0) {
    stop("Seasons must be greater than 0.")
  }

  WAR_per_season <- war / seasons

  dollar_value <-
    min(WAR_per_season, 1) * 7000000 +
    min(max(WAR_per_season - 1, 0), 1) * 8500000 +
    max(WAR_per_season - 2, 0) * 13000000

  cat("Estimated Annual Value:",
      scales::dollar(dollar_value, accuracy = 1),
      "\n")

  invisible(dollar_value)
}

