#' MLB Batting Statistics
#'
#' A dataset containing MLB player batting statistics used by
#' PlayerPredictorMLB to identify similar player seasons from
#' 2021-2026. This is a preview of the internal data.
#'
#' @format A data frame with 25 rows and 33 variables:
#' \describe{
#'   \item{Name}{Player name.}
#'   \item{Team}{Team the player played for during a particular season. Listed
#'   as "---" if they played for multiple teams.}
#'   \item{G}{Games played.}
#'   \item{PA}{Plate appearances.}
#'   \item{R}{Runs scored.}
#'   \item{RBI}{Runs batted in.}
#'   \item{SB}{Stolen bases.}
#'   \item{BB%}{Percentage of plate appearances where the batter walked.}
#'   \item{K%}{Percentage of plate appearances where the batter struck out.}
#'   \item{ISO}{Isolated power.}
#'   \item{BABIP}{Batting average on balls in play.}
#'   \item{AVG}{Batting average.}
#'   \item{OBP}{On-base percentage.}
#'   \item{SLG}{Slugging percentage.}
#'   \item{wOBA}{Weighted on-base average.}
#'   \item{xwOBA}{Expected weighted on-base average.}
#'   \item{wRC+}{Weighted runs created plus.}
#'   \item{BsR}{Base Running.}
#'   \item{Off}{Offensive runs above average.}
#'   \item{Def}{Defensive runs above average.}
#'   \item{WAR}{Wins above replacement.}
#'   \item{Season}{The season the stat line occurred in.}
#'   \item{Age}{The player's official age for the season.}
#'   \item{GB%}{The percentage of a batter’s balls in play that are ground
#'   balls.}
#'   \item{HR}{Home runs.}
#'   \item{HR/FB}{Ratio of home runs to fly balls.}
#'   \item{Barrel%}{Percent of a player's batted balls that are classified as a
#'   barrel.}
#'   \item{HardHit%}{Percentage of a player's batted balls that are classified
#'   as hard hit balls.}
#'   \item{xBA}{Expected batting average.}
#'   \item{xSLG}{Expected slugging percentage.}
#'   \item{NameASCII}{Player name using only ASCII characters.}
#'   \item{PlayerId}{Unique player identifier that can be used to link to other
#'   datasets that use PlayerID.}
#'   \item{MLBAMID}{Unique player identifier called Major League Baseball
#'   Advanced Media ID that can be used to link to other datasets that use
#'   MLBAMID.}
#' }
#'
#' @source FanGraphs.com
"BattingPreview"


#' MLB Pitching Statistics
#'
#' A dataset containing MLB player pitching statistics used by
#' PlayerPredictorMLB to identify similar player seasons from
#' 2021-2026. This is a preview of the internal data.
#'
#' @format A data frame with 25 rows and 37 variables:
#' \describe{
#'   \item{Name}{Player name.}
#'   \item{Team}{Team the player played for during a particular season. Listed
#'   as "---" if they played for multiple teams.}
#'   \item{W}{Pitcher wins.}
#'   \item{L}{Pitcher losses.}
#'   \item{SV}{Pitcher saves.}
#'   \item{G}{Games pitched.}
#'   \item{GS}{Games started.}
#'   \item{IP}{Innings pitched.}
#'   \item{K/9}{Strikeouts per nine innings pitched.}
#'   \item{BB/9}{Walks per nine innings pitched.}
#'   \item{HR/9}{Home runs per nine innings pitched.}
#'   \item{BABIP}{Opponents batting average on balls in play.}
#'   \item{HR/FB}{Home runs per fly ball.}
#'   \item{vFA (pi)}{Fastball velocity.}
#'   \item{ERA}{Earned run average.}
#'   \item{xERA}{Expected earned run average.}
#'   \item{FIP}{Fielding independent pitching.}
#'   \item{xFIP}{Expected fielding independent pitching.}
#'   \item{WAR}{Wins above replacement.}
#'   \item{Season}{The season the stat line occurred in.}
#'   \item{Age}{The player's official age for the season.}
#'   \item{AVG}{Opponents' batting average.}
#'   \item{LOB%}{Left-on-base percentagee}
#'   \item{GB%}{The percentage of a pitcher’s balls in play that are ground
#'   balls.}
#'   \item{K%}{Percentage of plate appearances that are strikeouts.}
#'   \item{BB%}{Percent of plate appearances that are walks.}
#'   \item{K-BB%}{Strikeout percentage minus walk percentage.}
#'   \item{Barrel%}{Percent of a pitcher's batted balls that are classified as
#'   a barrel.}
#'   \item{HardHit%}{Percentage of a player's batted balls that are classified
#'   as hard hit balls.}
#'   \item{BB}{Walks.}
#'   \item{SO}{Strikeouts.}
#'   \item{WHIP}{Walks and hits per inning pitched.}
#'   \item{NameASCII}{Player name using only ASCII characters.}
#'   \item{PlayerId}{Unique player identifier that can be used to link to other
#'   datasets that use PlayerID.}
#'   \item{MLBAMID}{Unique player identifier called Major League Baseball
#'   Advanced Media ID that can be used to link to other datasets that use
#'   MLBAMID.}
#'   \item{Is Starter}{Manually added binary variable that classifies a player
#'   season as a starting pitcher.}
#'   \item{Is Reliever}{Manually added binary variable that classifies a player
#'   season as a relief pitcher.}
#' }
#'
#' @source FanGraphs.com
"PitchingPreview"
