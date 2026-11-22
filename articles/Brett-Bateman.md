# Brett-Bateman

``` r

library(PlayerPredictorMLB)
```

## Introduction

For this vignette, we will walk through a real use case that this
package can help with. We will be examining the post-deadline
performance of Brett Bateman. As much as I want to believe it was real,
it was a small sample, and the underlying numbers may not support what
he did.

It didn’t take long for Bateman to make his MLB debut after being
acquired for Kevin Gausman, and the 24-year-old outfielder appeared in
41 games. He quickly made his mark, hitting .329/.402/.424 with 28 runs,
11 RBIs, and a 1.9 WAR. Despite not being known for his power, he hit
two home runs, including one at Rogers Centre before Vladimir Guerrero
Jr. was able to snap his drought. He produced a 138 WRC+ and 6 DRS,
showcasing excellent offensive and defensive value. If that can be
sustained over a full season, the Jays have a future star on their
hands, and it could be cool to see if the numbers support it!

### Finding Similar Batters

The first step to understand what Bateman accomplished is to find
players that profile as similar to him. Your first thought may be that
with a small sample, the projections wouldn’t work, but all inputs of
the function are rate stats. They may be sensitive to the small samples,
but Bateman only having 28 runs or 7 doubles won’t be held against him.

To find similar players, what is needed are Bateman’s stats from
FanGraphs. You need his BB%, K%, HR/FB rate, Barrel%, HardHit%, xBA,
xSLG, and xwoBA. The last piece is the number of similar player-seasons
you want to see.

``` r

similar_bateman <- similar_batters(
bb_pct = 9.9,
k_pct = 19.3,
hr_fb = 8.7,
barrel_pct = 1.6,
hardhit_pct = 19.8,
xba = 0.268,
xslg = 0.338,
xwoba = 0.312,
n = 10
)

similar_bateman
#>                Name Season Age  PA   AVG   OBP   SLG  wOBA HR  R RBI  wRC+ WAR
#> 1    Nolan Schanuel   2024  22 607 0.250 0.343 0.362 0.315 13 62  54 106.6 0.8
#> 2       Myles Straw   2021  26 638 0.271 0.349 0.348 0.311  4 86  48  97.8 3.1
#> 3      Adam Frazier   2023  31 455 0.240 0.300 0.396 0.302 13 59  60  92.7 0.4
#> 4     Jake McCarthy   2024  26 495 0.285 0.349 0.400 0.329  8 66  56 110.7 3.0
#> 5      Brice Turang   2024  24 619 0.254 0.316 0.349 0.294  7 72  57  88.4 2.6
#> 6       Sal Frelick   2025  25 594 0.288 0.351 0.405 0.332 12 76  63 114.2 3.6
#> 7     J.P. Crawford   2021  26 687 0.273 0.338 0.376 0.314  9 89  54 102.8 3.1
#> 8      Ha-Seong Kim   2023  27 626 0.260 0.351 0.398 0.330 17 84  60 110.2 4.2
#> 9      Bryson Stott   2024  26 571 0.245 0.315 0.356 0.296 11 65  57  85.4 1.7
#> 10 Charlie Blackmon   2024  37 499 0.256 0.329 0.412 0.323 12 59  52  94.3 0.1
```

The results are not overly inspiring, but this is not surprising. Most
light hitters don’t have the best success, and being compared to Nolan
Schanuel and Myles Straw is not exactly a glowing endorsement. That
being said, there are a lot of positives. We see 2024 Jake McCarthy and
Brice Turang, both of who had excellent 2026 seasons. Turang in
particular, as he finished a distant third in MVP voting, and both these
guys are capable defenders like Bateman. 2025 Sal Frelick, 2021 J.P.
Crawford, and 2023 Ha-Seong Kim all had strong seasons as well, giving
us a nice range of potential outcomes for Bateman.

### WAR Calculator

The next step is to get an approximate value of what Brett Bateman’s
performance would be worth. We can start with his two-month debut, as
Bateman was worth 1.9 fWAR.

``` r

bateman_war <- WAR_dollar_value_calculator(war = 1.9, seasons = 1)
#> Estimated Annual Value: $14,650,000

bateman_war
#> [1] 14650000
```

\$14,650,000 isn’t too shabby for 41 games, as the young outfielder was
worth far more than his minimum value salary. It’s unreasonable to
expect a center fielder to play a full 162 games, but 150 games is more
realistic. At his 41 game pace, that would equate to an even 7 WAR.

``` r

bateman_150_war <- WAR_dollar_value_calculator(war = 7, seasons = 1)
#> Estimated Annual Value: $80,500,000

bateman_150_war
#> [1] 80500000
```

That’s not quite PCA good, but if Bateman put up 7 WAR he’d be worth a
whopping \$80.5 million – far above the highest annual value for any MLB
player. No team would be willing to pay that, even for a Shohei Ohtani,
and it’s tough to expect that production from a second-year player.

A better potential gauge of his value would be using the similar
players, and we can set a range for his production. To do so, I took the
lowest WAR, Charlie Blackmon’s 0.1 in 2024, the highest WAR, Ha-Seong
Kim’s 4.2 in 2023, and the total WAR of all 10 player-seasons, which can
be summed and treated as a player’s 10-year career. That came out to
22.6.

``` r

similar_low_war <- WAR_dollar_value_calculator(war = 0.1, seasons = 1)
#> Estimated Annual Value: $700,000
similar_high_war <- WAR_dollar_value_calculator(war = 4.2, seasons = 1)
#> Estimated Annual Value: $44,100,000
similar_total_war <- WAR_dollar_value_calculator(war = 22.6, seasons = 10)
#> Estimated Annual Value: $18,880,000

similar_low_war
#> [1] 7e+05
similar_high_war
#> [1] 44100000
similar_total_war
#> [1] 18880000
```

On the low end, a \$700k season from Bateman next year would be a
disappointment, but the \$44.1 million for a 4.2 WAR season would be
considered a major win. Even the average \$18.88 million season value
would be acceptable, and is very similar to what Dalton Varsho produced
in 2025. His 2.2 WAR was worth just a tad under at \$18.1 million,
though it was injuries that held him to 71 games and not a full season
of production.

### Predicting 2027 Stats

The last thing to examine is what Bateman’s 2025 performance says about
his projected performance in 2027. We can use his stats to predict his
average, slugging, and wOBA for 2027, with the model putting the most
weight to the corresponding xStat.

``` r

bateman_avg <-predict_avg(
 age = 24,
 xba = 0.268,
 xslg = 0.338,
 xwoba = 0.312,
 bb_pct = 9.9,
 k_pct = 19.3,
 iso = 0.095,
 wrc_plus = 138,
 hr_fb = 8.7,
 barrel_pct = 1.6,
 hardhit_pct = 19.8
)

bateman_slg <-predict_slg(
 age = 24,
 xba = 0.268,
 xslg = 0.338,
 xwoba = 0.312,
 bb_pct = 9.9,
 k_pct = 19.3,
 iso = 0.095,
 wrc_plus = 138,
 hr_fb = 8.7,
 barrel_pct = 1.6,
 hardhit_pct = 19.8
)

bateman_woba <-predict_woba(
 age = 24,
 xba = 0.268,
 xslg = 0.338,
 xwoba = 0.312,
 bb_pct = 9.9,
 k_pct = 19.3,
 iso = 0.095,
 wrc_plus = 138,
 hr_fb = 8.7,
 barrel_pct = 1.6,
 hardhit_pct = 19.8
)

bateman_stats <-data.frame(
  AVG = bateman_avg,
  SLG = bateman_slg,
  wOBA = bateman_woba
)

bateman_stats
#>     AVG   SLG  wOBA
#> 1 0.266 0.346 0.308
```

The models predicted that for Bateman in 2027 he would hit .266 with a
.346 slugging and .308 wOBA, not the greatest overall production. It’s
not bad by any means, especially paired with his defense, but it also
makes sense. Bateman slugged well over .400 despite a 1.6 Barrell% and
19.8 HardHit%. Those are both well below average, and since few players
can succeed with those metrics, it makes sense that the models would not
expect Bateman to produce a .329 average, .424 slugging, and .368 wOBA,
because batters like him don’t usually do that. And really no one hits
.329!

### Future Exploration

This can be expanded upon using the newly predicted values. You can now
find similar players using the predicted average, slugging, and wOBA as
the xBA, xSLG, and see if that produces a different set of players. In
most cases it should be similar, but when analyzing different players
they may have large gaps between their season and the projections.

Further exploration can also be done on pitchers instead, as the package
has the ability to run a similar process on a pitcher. You can predict
ERA and FIP, as the functions account for the role the pitcher had or is
expected to have. Examples are provided with each function.

### Conclusion

As impressive as Brett Bateman’s debut was, the tools in this package
would not expect him to do as impressive in a full season. That’s not to
say he would not be valuable, as the ten most similar seasons produced
an average of 2.26 WAR, and two of the players with similar seasons in
2024 were outstanding in 2026. Bateman could take a similar path, but
regardless of if he keeps up this stellar production, his combination of
speed, defense, and contact ability will make him an important piece for
the 2027 Toronto Blue Jays.

As long as the MLB doesn’t spoil it with an extended lockout…
