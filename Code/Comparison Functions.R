##                                          ##
########## Standardization Function ########## 
##                                          ##

#' Calculate standardized similarity distances
#'
#' @param data A data frame containing baseball statistics.
#' @param target A named numeric vector containing the target statistics.
#' @param stats Character vector containing the comparison column names.
#'
#' @return A numeric vector containing standardized Euclidean distances.
#'
#' @keywords internal
.calculate_similarity <- function(data, target, stats) {
  
  ## Extract comparison columns
  comparison_data <- data[, stats, drop = FALSE]
  
  ## Confirm that all comparison columns are numeric
  non_numeric <- stats[!vapply(comparison_data, is.numeric, logical(1))]
  
  if (length(non_numeric) > 0) {
    stop(
      "The following comparison columns must be numeric: ",
      paste(non_numeric, collapse = ", "),
      call. = FALSE
    )
  }
  
  ## Calculate the mean and standard deviation of each statistic
  stat_means <- vapply(
    comparison_data,
    mean,
    numeric(1),
    na.rm = TRUE
  )
  
  stat_sds <- vapply(
    comparison_data,
    stats::sd,
    numeric(1),
    na.rm = TRUE
  )
  
  ## Standardize every player-season
  standardized_data <- sweep(
    as.matrix(comparison_data),
    MARGIN = 2,
    STATS = stat_means,
    FUN = "-"
  )
  
  standardized_data <- sweep(
    standardized_data,
    MARGIN = 2,
    STATS = stat_sds,
    FUN = "/"
  )
  
  ## Standardize the user-entered target using the same means and SDs
  standardized_target <- (target[stats] - stat_means) / stat_sds
  
  ## Calculate Euclidean distance from each player-season to the target
  distances <- sqrt(
    rowSums(
      sweep(
        standardized_data,
        MARGIN = 2,
        STATS = standardized_target,
        FUN = "-"
      )^2
    )
  )
  
  ## Rows missing any comparison statistic receive an undefined distance
  distances[!stats::complete.cases(comparison_data)] <- NA_real_
  
  distances
}

##                                            ##
########## Batter Comparison Function ########## 
##                                            ##

#' Find Similar Batter Seasons
#'
#' Finds the batter seasons most similar to a user-supplied statistical
#' profile using standardized Euclidean distance.
#'
#' @param bb_pct Walk Percentage.
#' @param k_pct Strikeout Percentage.
#' @param hr_fb Home Run per Fly Ball Percentage.
#' @param barrel_pct Barrel Percentage.
#' @param hardhit_pct Hard-Hit Percentage.
#' @param xba Expected Batting Average.
#' @param xslg Expected Slugging Percentage.
#' @param xwoba Expected Weighted On-Base Average.
#' @param n Number of Similar Player-Seasons to Return. Default is 5.
#' @param data Batting data frame. Default is `Batting`.
#'
#' @return A data frame containing the most similar batter seasons.
#'
#' @export
similar_batters <- function(
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
) {
  
  if (!is.numeric(n) || length(n) != 1L || n < 1) {
    stop("`n` must be a positive number.", call. = FALSE)
  }
  
  n <- as.integer(n)
  
  comparison_stats <- c(
    "BB%",
    "K%",
    "HR/FB",
    "Barrel%",
    "HardHit%",
    "xBA",
    "xSLG",
    "xwOBA"
  )
  
  target <- c(
    "BB%" = bb_pct,
    "K%" = k_pct,
    "HR/FB" = hr_fb,
    "Barrel%" = barrel_pct,
    "HardHit%" = hardhit_pct,
    "xBA" = xba,
    "xSLG" = xslg,
    "xwOBA" = xwoba
  )
  
  if (
    !is.numeric(target) ||
    length(target) != length(comparison_stats) ||
    anyNA(target) ||
    any(!is.finite(target))
  ) {
    stop(
      "All batter comparison statistics must be finite numeric values.",
      call. = FALSE
    )
  }
  
  return_columns <- c(
    "Name",
    "Season",
    "Age",
    "PA",
    "AVG",
    "OBP",
    "SLG",
    "wOBA",
    "HR",
    "R",
    "RBI",
    "wRC+"
  )
  
  missing_return_columns <- setdiff(return_columns, names(data))
  
  if (length(missing_return_columns) > 0) {
    stop(
      "The following return columns are missing from `Batting`: ",
      paste(missing_return_columns, collapse = ", "),
      call. = FALSE
    )
  }
  
  data$.distance <- .calculate_similarity(
    data = data,
    target = target,
    stats = comparison_stats
  )
  
  ## Remove rows that could not receive a distance
  results <- data[!is.na(data$.distance), , drop = FALSE]
  
  ## Sort by similarity score
  results <- results[order(results$.distance), , drop = FALSE]
  
  ## Keep the requested number of similar players
  results <- utils::head(results, n)
  
  ## Select requested output columns
  results <- results[, return_columns, drop = FALSE]
  
  ## Force rate stats to three decimal places
  rate_columns <- c("AVG", "OBP", "SLG", "wOBA")
  
  results[rate_columns] <- lapply(
    results[rate_columns],
    function(x) sprintf("%.3f", x)
  )
  
  rownames(results) <- NULL
  
  print(results, n = n)
}

## Example
similar_batters(
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

##                                             ##
########## Pitcher Comparison Function ########## 
##                                             ##

#' Find Similar Pitcher Seasons
#'
#' Finds the pitcher seasons most similar to a user-supplied statistical
#' profile. Comparisons are restricted to pitcher seasons matching the
#' selected starter and reliever classifications. Starter and reliever
#' classifications manually imputed based on innings pitched, ratio of starts
#' to relief outings, numerical gap in starts and games pitched, and subject
#' matter knowledge.
#'
#' @param lob_pct Left-on-Base Percentage.
#' @param gb_pct Ground Ball Percentage.
#' @param hr_fb Home Run per Fly Ball Percentage.
#' @param k_pct Strikeout Percentage.
#' @param bb_pct Walk Percentage.
#' @param barrel_pct Barrel Percentage.
#' @param hardhit_pct Hard-Hit Percentage.
#' @param is_starter Starter Indicator: either 0 or 1.
#' @param is_reliever Reliever Indicator: either 0 or 1.
#' @param n Number of similar player-seasons to return. Default is 5.
#' @param data Pitching data frame. Default is `Pitching`.
#'
#' @return A data frame containing the most similar pitcher seasons.
#'
#' @export
similar_pitchers <- function(
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
) {
  
  if (!is.numeric(n) || length(n) != 1L || n < 1) {
    stop("`n` must be a positive number.", call. = FALSE)
  }
  
  n <- as.integer(n)
  
  role_values <- c(is_starter, is_reliever)
  
  if (
    anyNA(role_values) ||
    length(role_values) != 2L ||
    !all(role_values %in% c(0, 1))
  ) {
    stop(
      "`is_starter` and `is_reliever` must each be either 0 or 1.",
      call. = FALSE
    )
  }
  
  if (is_starter == 0 && is_reliever == 0) {
    stop(
      "At least one of `is_starter` or `is_reliever` must equal 1.",
      call. = FALSE
    )
  }
  
  role_columns <- c("Is Starter", "Is Reliever")
  missing_role_columns <- setdiff(role_columns, names(data))
  
  if (length(missing_role_columns) > 0) {
    stop(
      "The following role columns are missing from `Pitching`: ",
      paste(missing_role_columns, collapse = ", "),
      call. = FALSE
    )
  }
  
  comparison_stats <- c(
    "LOB%",
    "GB%",
    "HR/FB",
    "K%",
    "BB%",
    "Barrel%",
    "HardHit%"
  )
  
  target <- c(
    "LOB%" = lob_pct,
    "GB%" = gb_pct,
    "HR/FB" = hr_fb,
    "K%" = k_pct,
    "BB%" = bb_pct,
    "Barrel%" = barrel_pct,
    "HardHit%" = hardhit_pct
  )
  
  if (
    !is.numeric(target) ||
    length(target) != length(comparison_stats) ||
    anyNA(target) ||
    any(!is.finite(target))
  ) {
    stop(
      "All pitcher comparison statistics must be finite numeric values.",
      call. = FALSE
    )
  }
  
  return_columns <- c(
    "Name",
    "Season",
    "Age",
    "IP",
    "W",
    "L",
    "SV",
    "ERA",
    "WHIP",
    "SO",
    "BB"
  )
  
  missing_return_columns <- setdiff(return_columns, names(data))
  
  if (length(missing_return_columns) > 0) {
    stop(
      "The following return columns are missing from `Pitching`: ",
      paste(missing_return_columns, collapse = ", "),
      call. = FALSE
    )
  }
  
  ## Keep only seasons with an exact role match
  role_match <- (
    data[["Is Starter"]] == is_starter &
      data[["Is Reliever"]] == is_reliever
  )
  
  filtered_data <- data[
    !is.na(role_match) & role_match,
    ,
    drop = FALSE
  ]
  
  if (nrow(filtered_data) == 0) {
    stop(
      "No pitcher seasons match the requested starter/reliever combination.",
      call. = FALSE
    )
  }
  
  filtered_data$.distance <- .calculate_similarity(
    data = filtered_data,
    target = target,
    stats = comparison_stats
  )
  
  ## Remove rows that could not receive a distance
  results <- filtered_data[
    !is.na(filtered_data$.distance),
    ,
    drop = FALSE
  ]
  
  if (nrow(results) == 0) {
    stop(
      "No matching pitcher seasons have complete comparison statistics.",
      call. = FALSE
    )
  }
  
  ## Sort by similarity score
  results <- results[order(results$.distance), , drop = FALSE]
  
  ## Keep requested results
  results <- utils::head(results, n)
  
  ## Select requested output columns
  results <- results[, return_columns, drop = FALSE]
  
  rownames(results) <- NULL
  
  print(results, n = n)
}

## Traditional Starter Example
similar_pitchers(
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
similar_pitchers(
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
similar_pitchers(
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

##     ##
## End ##
##     ##   
