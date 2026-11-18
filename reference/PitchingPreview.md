# MLB Pitching Statistics

A dataset containing MLB player pitching statistics used by
PlayerPredictorMLB to identify similar player seasons from 2021-2026.
This is a preview of the internal data.

## Usage

``` r
PitchingPreview
```

## Format

A data frame with 25 rows and 37 variables:

- Name:

  Player name.

- Team:

  Team the player played for during a particular season. Listed as "—"
  if they played for multiple teams.

- W:

  Pitcher wins.

- L:

  Pitcher losses.

- SV:

  Pitcher saves.

- G:

  Games pitched.

- GS:

  Games started.

- IP:

  Innings pitched.

- K/9:

  Strikeouts per nine innings pitched.

- BB/9:

  Walks per nine innings pitched.

- HR/9:

  Home runs per nine innings pitched.

- BABIP:

  Opponents batting average on balls in play.

- HR/FB:

  Home runs per fly ball.

- vFA (pi):

  Fastball velocity.

- ERA:

  Earned run average.

- xERA:

  Expected earned run average.

- FIP:

  Fielding independent pitching.

- xFIP:

  Expected fielding independent pitching.

- WAR:

  Wins above replacement.

- Season:

  The season the stat line occurred in.

- Age:

  The player's official age for the season.

- AVG:

  Opponents' batting average.

- LOB%:

  Left-on-base percentagee

- GB%:

  The percentage of a pitcher’s balls in play that are ground balls.

- K%:

  Percentage of plate appearances that are strikeouts.

- BB%:

  Percent of plate appearances that are walks.

- K-BB%:

  Strikeout percentage minus walk percentage.

- Barrel%:

  Percent of a pitcher's batted balls that are classified as a barrel.

- HardHit%:

  Percentage of a player's batted balls that are classified as hard hit
  balls.

- BB:

  Walks.

- SO:

  Strikeouts.

- WHIP:

  Walks and hits per inning pitched.

- NameASCII:

  Player name using only ASCII characters.

- PlayerId:

  Unique player identifier that can be used to link to other datasets
  that use PlayerID.

- MLBAMID:

  Unique player identifier called Major League Baseball Advanced Media
  ID that can be used to link to other datasets that use MLBAMID.

- Is Starter:

  Manually added binary variable that classifies a player season as a
  starting pitcher.

- Is Reliever:

  Manually added binary variable that classifies a player season as a
  relief pitcher.

## Source

FanGraphs.com
