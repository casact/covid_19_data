# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

#' This script has been modified from original work found 
#' at: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide

library(tidyverse)
library(httr)
library(readxl)

url <- paste0(
  "https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-"
  , format(Sys.time(), "%Y-%m-%d")
  , ".xlsx")

GET(
  url
  , authenticate(":", ":", type="ntlm")
  , write_disk(tf <- tempfile(fileext = ".xlsx"))
)

tbl_ecdc <- read_excel(tf) %>% 
  rename(
    population = popData2018
    , country = `countriesAndTerritories`) %>% 
  select(-day, -month, -year)

tbl_ecdc <- tbl_ecdc %>% 
  group_by(country) %>% 
  arrange(dateRep, .by_group = TRUE) %>% 
  mutate(
    cumulative_reported = cumsum(cases)
    , cumulative_deaths = cumsum(deaths)
  ) %>% 
  ungroup()

save(
  file = file.path('data', 'ecdc.rda')
  , tbl_ecdc
)
