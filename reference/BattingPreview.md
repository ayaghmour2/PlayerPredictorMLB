# MLB Batting Statistics

A dataset containing MLB player batting statistics used by
PlayerPredictorMLB to identify similar player seasons from 2021-2026.
This is a preview of the internal data.

## Usage

``` r
BattingPreview
```

## Format

A data frame with 25 rows and 33 variables:

- Name:

  Player name.

- Team:

  Team the player played for during a particular season. Listed as "—"
  if they played for multiple teams.

- G:

  Games played.

- PA:

  Plate appearances.

- R:

  Runs scored.

- RBI:

  Runs batted in.

- SB:

  Stolen bases.

- BB%:

  Percentage of plate appearances where the batter walked.

- K%:

  Percentage of plate appearances where the batter struck out.

- ISO:

  Isolated power.

- BABIP:

  Batting average on balls in play.

- AVG:

  Batting average.

- OBP:

  On-base percentage.

- SLG:

  Slugging percentage.

- wOBA:

  Weighted on-base average.

- xwOBA:

  Expected weighted on-base average.

- wRC+:

  Weighted runs created plus.

- BsR:

  Base Running.

- Off:

  Offensive runs above average.

- Def:

  Defensive runs above average.

- WAR:

  Wins above replacement.

- Season:

  The season the stat line occurred in.

- Age:

  The player's official age for the season.

- GB%:

  The percentage of a batter’s balls in play that are ground balls.

- HR:

  Home runs.

- HR/FB:

  Ratio of home runs to fly balls.

- Barrel%:

  Percent of a player's batted balls that are classified as a barrel.

- HardHit%:

  Percentage of a player's batted balls that are classified as hard hit
  balls.

- xBA:

  Expected batting average.

- xSLG:

  Expected slugging percentage.

- NameASCII:

  Player name using only ASCII characters.

- PlayerId:

  Unique player identifier that can be used to link to other datasets
  that use PlayerID.

- MLBAMID:

  Unique player identifier called Major League Baseball Advanced Media
  ID that can be used to link to other datasets that use MLBAMID.

## Source

FanGraphs.com
