# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Data from https://covidtracking.com/api

library(tidyverse)

tbl_current <- read_csv('https://covidtracking.com/api/v1/states/current.csv') %>% 
  janitor::clean_names()

tbl_historical <- read_csv('https://covidtracking.com/api/v1/states/daily.csv') %>% 
  janitor::clean_names()

tbl_historical <- tbl_historical %>% 
  group_by(state) %>% 
  arrange(date, .by_group = TRUE) %>% 
  tidyr::fill(death, hospitalized, total, total_test_results) %>% 
  ungroup()

save(
  file = file.path('data', 'covid_tracking.rda')
  , tbl_current
  , tbl_historical
)
