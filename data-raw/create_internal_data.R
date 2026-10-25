## code to prepare `create_internal_data` dataset goes here

library(readxl)

Batting <- read_excel("data-raw/Batting Stats.xlsx")
Pitching <- read_excel("data-raw/Pitching Stats.xlsx")

usethis::use_data(
  Batting,
  Pitching,
  internal = TRUE,
  overwrite = TRUE
)
